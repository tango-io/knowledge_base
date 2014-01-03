class SessionsController < ApplicationController
  before_filter :validate_tango_user

  def create
    user_data = request.env['omniauth.auth']
    user      = SessionsHandler.find_or_create_user(user_data)

    if user
      session[:user_id] = user.id
      redirect_to root_path
    else
      redirect_to root_path, alert: 'It wasn\'t possible to log you in.'
    end
  end

  private

  def validate_tango_user
    email = request.env['omniauth.auth']['info']['email']

    unless SessionsHandler.tango_email?(email)
      redirect_to root_path, alert: 'Only TangoSource users are allowed.'
    end
  end
end
