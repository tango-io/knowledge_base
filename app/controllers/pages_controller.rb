class PagesController < ApplicationController
  def index
    if user_signed_in?
      @documents = get_documents
    else
      @documents = Document.all
    end
  end
end
