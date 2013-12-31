require 'faker'

module OauthReponse
  def self.response
    {
      'provider' => 'google_oauth2',
      'uid' => rand(100),
      'info' => {
        'name' => Faker::Lorem.word,
        'email' => "#{Faker::Lorem.word}@tangosource.com",
        'first_name' => Faker::Name.name,
        'last_name' => Faker::Name.last_name,
        'image' => Faker::Internet.url,
      },
      'credentials' => {
        'token' => Faker::Code.isbn,
        'refresh_token' => Faker::Code.isbn,
        'expires_at'=> rand(100),
        'expires' => true
      }
    }
  end
end
