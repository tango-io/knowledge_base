class DocumentsController < ApplicationController
  before_filter :find_document, only: [:edit, :update, :show, :destroy]

  def new
    @document = Document.new
  end

  def show
  end

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

  def destroy
    if @document.destroy
      redirect_to root_path
    else
      redirect_to root_path
      flash.now[:alert] = 'Error while deleting document!'
    end
  end

  private

  def find_document
    @document = Document.find(params[:id])
  end

  def doc_params
    params.require(:document).permit(:title, :body, :tag_list)
  end

end
