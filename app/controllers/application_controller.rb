class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :get_user

  def get_user
    if user_signed_in?
      @user = User.find(session[:user_id])
    end
  end

  def user_signed_in?
    session[:user_id]
  end
end
