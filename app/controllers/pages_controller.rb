class PagesController < ApplicationController
  def index
    if user_signed_in?
      @documents = Document.all
    else
      render template: 'pages/landing_page', layout: 'welcome'
    end
  end

  def user_signed_in?
    false
  end
end
