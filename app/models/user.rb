class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, 
         :recoverable, :rememberable, :validatable, :trackable

  # Override Devise::Models::Authenticatable methods
  def active_for_authentication? 
    super && approved? 
  end 
  # TODO troubleshoot how this communicates with config/locals/devise.en.yml to generate correct message
    # en.devise.failure.unauthenticated i/o en.devise.registrations.user.signed_up_bot_not_approved
  def inactive_message 
    approved? ? super : :not_approved
  end
end
