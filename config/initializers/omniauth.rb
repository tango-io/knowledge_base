yaml_file_route = if File.exists?('config/google_credentials.local.yml')
                    'config/google_credentials.local.yml'
                  else
                    'config/google_credentials.yml'
                  end

GOOGLE_CREDENTIALS = YAML.load_file(Rails.root.join(yaml_file_route))[Rails.env]

Rails.application.config.middleware.use OmniAuth::Builder do
  provider(
    :google_oauth2,
    GOOGLE_CREDENTIALS['google_key'],
    GOOGLE_CREDENTIALS['google_secret'],
  )
end

OmniAuth.config.test_mode = Rails.env.test?
