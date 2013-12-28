Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV['810924789923.apps.googleusercontent.com'], ENV['q9-z-6a_GM5HxaaAHEAR_fGA']
end
