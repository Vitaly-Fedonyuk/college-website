class DocumentsController < ApplicationController
  def index
    @documents = Document.all.order(created_at: :desc)
  end

  def new
    @document = Document.new
  end

  def create
    @document = Document.new(document_params)
    
    if @document.save
      redirect_to documents_path, notice: 'Документ успішно завантажено.'
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  private
  
  def document_params
    params.require(:document).permit(:name, :description, :file)
  end
end
