class PagesController < ApplicationController
  def index
    if user_signed_in?
      @documents = get_documents
    else
      render template: 'pages/landing_page', layout: 'welcome'
    end
  end

  def user_signed_in?
    false
  end

  private

  def get_documents
    if params.include? :search
      Document.search_by_title(params[:search])
    else
      Document.all
    end
  end

end
