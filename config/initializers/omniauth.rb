GOOGLE_CREDENTIALS = YAML.load_file(Rails.root.join('config/google_credentials.yml'))[Rails.env]

Rails.application.config.middleware.use OmniAuth::Builder do
  provider(
    :google_oauth2,
    GOOGLE_CREDENTIALS['google_key'],
    GOOGLE_CREDENTIALS['google_secret'],
  )
end
