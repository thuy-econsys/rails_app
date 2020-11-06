class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, 
         :recoverable, :rememberable, :validatable, :trackable

  validates :phone, presence: true
  validate :email_input, :password_input, :phone_input

  def email_input
    return if email =~ /\A(([a-z0-9][\w\.\-]{0,62}[a-z0-9])@(([a-z0-9][a-z0-9\-]{0,62}[a-z0-9]\.){1,8})([a-z]{2,63}))\z/

    errors.add(:email, 'must be a valid address.')
  end

  def password_input
    return if password =~ /\A(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{6,70}\z/

    errors.add(:password, 'must be at least 6 characters long, and include 1 uppercase, 1 lowercase, 1 digit and 1 special character.')
  end

  def phone_input
    return if phone =~ /\A[+]?[1]?[ ]?([\(]?([0-9]{3})[\)]?[ \.\-]?([0-9]{3})[ \-\.]?([0-9]{4})([ ]?((;|x|#|extension|ext)?)[ ]?([0-9]{0,6})))\z/

    errors.add(:phone, 'needs to be a valid number.')
  end

  # Override Devise::Models::Authenticatable methods
  def active_for_authentication? 
    super && approved? 
  end 
  def inactive_message 
    approved? ? super : :not_approved
  end
end
