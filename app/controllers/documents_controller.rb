class DocumentsController < ApplicationController
  before_filter :find_document, only: [:edit, :update, :show]

  def new
    @document = Document.new()
  end

  def show
  end

  def create
    @document = Document.new(doc_params)
    if @document.save
      redirect_to @document
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @document.update(doc_params)
      redirect_to(@document)
    else
      render :edit
    end
  end

  private

  def find_document
    @document = Document.find(params[:id])
  end

  def doc_params
    params.require(:document).permit(:title, :body)
  end

end
