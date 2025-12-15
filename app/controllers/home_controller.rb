class HomeController < ApplicationController
  def index
    @recent_news = News.published.limit(3)
  end
end
