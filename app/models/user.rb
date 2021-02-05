class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable, #:reconfirmable,
         :recoverable, :rememberable, :validatable, :trackable

  # opt for custom validation over validates_format_of for Devise as validates_format_of:
    # validates even when there's no field present in edits
    # causes non-valid fields created prior to implementing validations to fail, ie password
  validate :phone_input, :password_input
  
  def password_input
    if password.present? && !password.match(/\A(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).*\z/)
      errors.add(:password, 'must include 1 uppercase, 1 lowercase, 1 digit and 1 special character.')
    end
    # return if password.blank? || password =~ /\A(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).*\z/

    # errors.add :password, 'must include 1 uppercase, 1 lowercase, 1 digit and 1 special character.'
  end
  def phone_input
    if phone.present? && !phone.match(/\A[+]?[1]?[ \.\-]?([\(]?([0-9]{3})[\)]?[ \.\-]?([0-9]{3})[ \-\.]?([0-9]{4})[ ]?(;|#|x|extension|ext)?[ ]?([0-9]{0,6}))\z/i)
      errors.add(:phone, 'needs to be a valid number')
    end
  end

  # Override Devise::Models::Authenticatable methods
  def active_for_authentication? 
    super && approved? 
  end 
  def inactive_message 
    approved? ? super : :not_approved
  end
end
