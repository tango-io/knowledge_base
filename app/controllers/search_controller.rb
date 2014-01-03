class SearchController < ApplicationController
  def index
    @documents = Document.search(params[:search])
  end
end
