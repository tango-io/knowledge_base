class SessionsController < ApplicationController
  before_filter :validate_tango_user

  def create
    user = find_or_create_user

    if user
      session[:user_id] = user.id
      redirect_to root_path
    end
  end

  private

  def find_or_create_user
    uid           = request.env['omniauth.auth']['uid'].to_s
    existent_user = User.find_by(uid: uid)

    return existent_user if existent_user
    create_user
  end

  def create_user
    user_data             = request.env['omniauth.auth']
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

  def validate_tango_user
    email = request.env['omniauth.auth']['info']['email']

    unless tango_email?(email)
      render(
        text: 'Only Tangosource emails are allowed.',
        status: :unauthorized
      )
    end
  end

  def tango_email?(email)
    email.match(/@tangosource.com/)
  end
end
