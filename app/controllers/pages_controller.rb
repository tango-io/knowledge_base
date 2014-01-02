class PagesController < ApplicationController
  def index
    if user_signed_in?
      @documents = Document.all
    else
      return render template: 'pages/landing_page', layout: 'welcome'
    end
  end

  def user_signed_in?
    true
  end
end
