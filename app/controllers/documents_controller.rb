class DocumentsController < ApplicationController
  expose(:document)

  def create
    if document.save
      redirect_to document
    else
      render :new
    end
  end

  def update
    if document.save
      redirect_to document
    else
      render :edit
    end
  end

end
