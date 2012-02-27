Rishi::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # In the development environment your application's code is reloaded on
  # every request.  This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false
  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true


  # initialize ActiveMerchant Gem
  # Paypal sandbox mode
  config.after_initialize do
  ActiveMerchant::Billing::Base.mode = :test
  ::GATEWAY = ActiveMerchant::Billing::PaypalGateway.new(
    :login => "frishi_1330355950_biz_api1.me.com",
    :password => "1330355974",
    :signature => "AFcWxV21C7fd0v3bYYYRCpSSRl31A6exnpjtp5fQk8Lkmb0aqnfB6enT"
   )
  end

  #configuration for devise
  config.action_mailer.default_url_options = { :host => 'localhost:3000' }
  
  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin

  # Do not compress assets
  config.assets.compress = false

  # Expands the lines which load the assets
  config.assets.debug = true
end
