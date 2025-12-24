class Admin::DocumentsController < Admin::BaseController
  before_action :set_document, only: [:edit, :update, :destroy]
  
  def index
    @documents = Document.ordered.page(params[:page]).per(20)
  end
  
  def new
    @document = Document.new
  end
  
  def create
    @document = Document.new(document_params)
    
    if @document.save
      redirect_to admin_documents_path, notice: 'Документ успішно створено.'
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  def edit
  end
  
  def update
    if @document.update(document_params)
      redirect_to admin_documents_path, notice: 'Документ успішно оновлено.'
    else
      render :edit, status: :unprocessable_entity
    end
  end
  
  def destroy
    @document.destroy
    redirect_to admin_documents_path, notice: 'Документ успішно видалено.'
  end
  
  private
  
  def set_document
    @document = Document.find(params[:id])
  end
  
  def document_params
    params.require(:document).permit(:name, :description, :category, :file)
  end
end
