class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  protected
  
  #FIXME alternative solution for 'approved' attribute as this might allow user to self approve
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:notes])
    devise_parameter_sanitizer.permit(:accept_invitation, keys: [:notes])
  end
end
