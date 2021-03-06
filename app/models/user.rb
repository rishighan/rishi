class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  if Rails.env.production?
    devise :database_authenticatable, :recoverable, :rememberable, :registerable, :trackable, :validatable
  
  else
    devise :database_authenticatable, :recoverable, :registerable, :rememberable, :trackable, :validatable
  
end
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
end
