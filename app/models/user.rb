class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable
  devise :registerable, :database_authenticatable,
        :recoverable, :rememberable, :validatable, :trackable,
        :omniauthable, omniauth_providers: [:google_oauth2] 

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

  def self.from_omniauth(auth)
    where(email: auth[:email]).first_or_create do |user|
      user.email = auth[:email] #auth.info.email
      user.password = Devise.friendly_token[0,20]

      # If you are using confirmable and the provider(s) you use validate emails, 
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
      
      # ensure only EconSys domain allowed
      # FIXME? GCP auto redirects to 403
      # if !(user.email =~ /@econsys.com\z/).nil?
      #   user.save
      # end
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
