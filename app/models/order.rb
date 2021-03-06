class Order < ActiveRecord::Base

  validates :firstname, :lastname, :address1, :address2, :city, :state, :zipcode, :phone, :email, :pay_type,
  :presence => true

  has_many :line_items, :dependent => :destroy

  has_many :transactions, :class_name => "OrderTransaction"
  attr_accessor :card_number, :card_verification, :card_expires_on

  # Phone Number Validation
  # regex [\(?0-9 \)?]{3,6}?-?[0-9]{3} ?-?[0-9]{4}
  # for matching:
  # 2154701106 or 215 470 1106 or (215) 470-1106 or 215-470-1106
  validates_format_of :phone, :with => /^[\(?0-9 \)?]{3,6}?-?[0-9]{3} ?-?[0-9]{4}$/,
  :notice => 'Phone numbers can have the following format'

  before_save :clean_phone_number

  # E-mail validation
  # regex ([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})
  # for matching:
  # frishi@me.com, frishi@yahoo.co.in
  validates_format_of :email, :with => /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/,
  :notice => 'Enter a valid email address'

  # payment types
  PAYMENT_TYPES = ["Visa",  "MasterCard", "Discover", "American Express"]

  # Payment type validation
  # This is important to prevent HTML injection
  validates :pay_type,  :inclusion => PAYMENT_TYPES

  def clean_phone_number
    ph = self.phone.gsub(/([-()])/, '')
  end

  # Credit Card Validation
  validate :validate_card, :on =>:create

  # CC validation method taken from Ryan Bate's Railscast #145
  # checks the CC info and adds any error messages to the order model's error messages.
  def validate_card
    unless credit_card.valid?
      credit_card.errors.full_messages.each do |message|
        self.errors.add :base, message
      end
    end
  end

  def credit_card
    @credit_card ||= ActiveMerchant::Billing::CreditCard.new(
    :type               => pay_type,
    :number             => card_number,
    :verification_value => card_verification,
    :month              => card_expires_on.month,
    :year               => card_expires_on.year,
    :first_name         => firstname,
    :last_name          => lastname
    )
  end

  def purchase_options
    {
      :ip => ip_address,
      :billing_address => {
        :name     => firstname,
        :address1 => address1,
        :city     => city,
        :state    => state,
        :country  => "US",
        :zip      => zipcode
      }
    }
  end

  # please dont use hard-coded prices, cos, like, its not the best practice?
  def purchase
    response = GATEWAY.purchase(price_in_cents, credit_card, purchase_options)
    transactions.create!(:action => "purchase", :amount => price_in_cents, :response => response)
    #cart.update_attribute(:purchased_at, Time.now) if response.success?
    response.success?
  end

  def total_price
    line_items.to_a.sum {|item| item.total_price}
  end

  def price_in_cents
    (total_price*100).round
  end

  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end

end
