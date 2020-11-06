class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, 
         :recoverable, :rememberable, :validatable, :trackable

  validates :phone, presence: true
  
  validates_format_of :email,
    with: /\A(([a-z0-9][\w\.\-]{0,62}[a-z0-9])@(([a-z0-9][a-z0-9\-]{0,62}[a-z0-9]\.){1,8})([a-z]{2,63}))\z/, 
    message: 'must be a valid address.'
  validates_format_of :password,
    with: /\A(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{6,70}\z/, 
    message: 'must include 1 uppercase, 1 lowercase, 1 digit and 1 special character.'
  validates_format_of :phone,
    with: /\A[+]?[1]?[ ]?([\(]?([0-9]{3})[\)]?[ \.\-]?([0-9]{3})[ \-\.]?([0-9]{4})([ ]?((;|x|#|extension|ext)?)[ ]?([0-9]{0,6})))\z/i, 
    message: 'needs to be a valid number.'

  # Override Devise::Models::Authenticatable methods
  def active_for_authentication? 
    super && approved? 
  end 
  def inactive_message 
    approved? ? super : :not_approved
  end
end
