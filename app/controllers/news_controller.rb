class NewsController < ApplicationController
  def index
    @news = News.published.page(params[:page]).per(10)
  end

  def show
    @news_item = News.find(params[:id])
  end
end
