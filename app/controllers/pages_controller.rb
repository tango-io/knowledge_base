class PagesController < ApplicationController
  def index
    if user_signed_in?
      @documents = get_documents
    else
      @documents = Document.all
    end
  end

  def get_documents
    if params.include? :search
      Document.search_by_title(params[:search])
    else
      Document.all
    end
  end
end
