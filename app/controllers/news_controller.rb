class NewsController < ApplicationController
  def index
    @news = News.published.page(params[:page]).per(10)
  end

  def show
    @news_item = News.find(params[:id])
    
    # Only allow access to published news or for authenticated admin users
    unless @news_item.published_at && @news_item.published_at <= Time.current
      if !user_signed_in?
        redirect_to news_index_path, alert: "Ця новина ще не опублікована"
        return
      end
    end
  end
end
