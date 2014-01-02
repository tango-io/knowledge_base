class PagesController < ApplicationController
  def index
    if user_signed_in?
      @documents = Document.all
    else
      render template: 'pages/landing_page', layout: 'welcome'
    end

    @user = User.find(session[:user_id])
  end

  def user_signed_in?
    session[:user_id]
  end
end
