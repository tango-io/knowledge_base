class PagesController < ApplicationController
  def index
    unless user_signed_in?
      return render template: 'pages/landing_page', layout: 'welcome'
    end

    @user = User.find(session[:user_id])
  end

  private

  def user_signed_in?
    !session[:user_id].nil?
  end
end
