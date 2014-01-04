class SearchController < ApplicationController
  def index
    @documents = if params[:tag]
                   Document.tagged_with(params[:tag])
                 else
                   Document.search(params[:search])
                 end
    @pattern = params[:search] || params[:tag]
  end
end
