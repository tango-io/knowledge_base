class DocumentsController < ApplicationController
  before_filter :build_document, only: [:new, :create]
  before_filter :find_document, only: [:edit, :update]

  def new
  end

  def create
    if @document.save
      redirect_to @document
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @document.update_attributes(doc_params)
      redirect_to(@document)
    else
      render :edit
    end
  end

  def build_document
    @document = document.new(doc_params)
  end

  def find_document
    @document = document.find(params[:id])
  end

  def doc_params
    params.require(:document).permit(:title, :body)
  end

end
