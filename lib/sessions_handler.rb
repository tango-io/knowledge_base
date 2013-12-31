class SessionsHandler
  class << self
    def find_or_create_user(user_data)
      uid           = user_data['uid'].to_s
      existent_user = User.find_by(uid: uid)

      return existent_user if existent_user
      create_user(user_data)
    end

    def tango_email?(email)
      email.match(/@tangosource.com/)
    end

    private

    def create_user(user_data)
      user_data_info        = user_data['info']
      user_data_credentials = user_data['credentials']

      User.create(
        uid: user_data['uid'],
        name: user_data_info['name'],
        email: user_data_info['email'],
        first_name: user_data_info['first_name'],
        last_name: user_data_info['last_name'],
        image: user_data_info['image'],
        token: user_data_credentials['token'],
        token_refresh_token: user_data_credentials['refresh_token'],
        token_expires_at: user_data_credentials['expires_at']
      )
    end
  end
end
