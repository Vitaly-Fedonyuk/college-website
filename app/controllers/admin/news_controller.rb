class Admin::NewsController < Admin::BaseController
  before_action :set_news_item, only: [:show, :edit, :update, :destroy, :preview]
  
  def index
    @news = News.order(created_at: :desc).page(params[:page]).per(20)
  end
  
  def show
  end
  
  def new
    @news_item = News.new
  end
  
  def create
    @news_item = News.new(news_params)
    
    if @news_item.save
      redirect_to admin_news_index_path, notice: 'Новину успішно створено.'
    else
      render :new, status: :unprocessable_entity
    end
  end
  
  def edit
  end
  
  def update
    if @news_item.update(news_params)
      redirect_to admin_news_index_path, notice: 'Новину успішно оновлено.'
    else
      render :edit, status: :unprocessable_entity
    end
  end
  
  def destroy
    @news_item.destroy
    redirect_to admin_news_index_path, notice: 'Новину успішно видалено.'
  end
  
  def preview
    # Temporarily update attributes for preview without saving
    @news_item.assign_attributes(news_params) if params[:news]
    render layout: 'application'
  end
  
  private
  
  def set_news_item
    @news_item = News.find(params[:id])
  end
  
  def news_params
    params.require(:news).permit(:title, :content, :published_at, :image)
  end
end
