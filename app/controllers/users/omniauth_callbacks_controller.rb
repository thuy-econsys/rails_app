# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # See https://github.com/omniauth/omniauth/wiki/FAQ#rails-session-is-clobbered-after-callback-on-developer-strategy
  skip_before_action :verify_authenticity_token, only: :google_oauth2

  def google_oauth2
    user = User.from_omniauth(google_params) # debug with auth

    if user.present?
      sign_out_all_scopes
      flash[:success] = t 'devise.omniauth_callbacks.success', kind: 'Google'
      sign_in_and_redirect(user, event: :authentication)
    else
      flash[:alert] = t 'devise.omniauth_callbacks.failure', kind: 'Google', reason: "#{auth.info.email} is not authorized."
      redirect_to(new_user_session_url)
    end
  end

  # GET|POST /resource/auth/google_oauth2
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/google_oauth2/callback
  # def failure
  #   super
  # end

  protected
  
  # The path used when OmniAuth fails
  # def after_omniauth_failure_path_for(scope)
  #   new_user_session_path
  # end

  # def after_sign_in_path_for(resource)
  #   request.env['omniauth.origin'] || root_path
  # end

  private

  # restricting which info from OmniAuth hash can be accessed
  def google_params
    @google_params ||= {
      # uid: auth.uid,
      # provider: auth.provider,
      email: auth.info.email
    }
  end

  # OmniAuth data from provider, available as a hash 
    # auth.uid, auth.provider, auth.info.email
    # auth.credentials.token = <access_token>
      # should also receive refresh_token and expires_at timestamp for succesful auth
    # auth.extra.id_info.iss = https://accounts.google.com
    # auth.extra.id_info.hd = econsys.com
    # auth.extra.id_token = <user_profile_token> (email)
  def auth
    @auth ||= request.env['omniauth.auth']
  end
end
