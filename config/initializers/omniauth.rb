OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV['GCP_CLIENT_ID'], ENV['GCP_CLIENT_SECRET'], {
    scope: [
      'email',
      'https://www.googleapis.com/auth/gmail.modify'],
      access_type: 'offline'
  }
end

# Rails.application.config.middleware.use OmniAuth::Builder do
#   provider :twitter, Rails.application.secrets.omniauth_provider_key, Rails.application.secrets.omniauth_provider_secret
# end

# Rails.application.config.middleware.use OmniAuth::Builder do
#   provider :cas, host: 'cas.yourdomain.com', url: 'yourdomain.com',
#   fetch_raw_info: Proc.new { |strategy, opts, ticket, user_info, rawxml|
#     return {} if user_info.empty? || rawxml.nil? # Auth failed

#     extra_info = ExternalService.get(user_info[:user]).attributes
#     extra_info.merge!({'roles' => rawxml.xpath('//cas:roles').map(&:text)})
#     extra_info
#   }
# end
