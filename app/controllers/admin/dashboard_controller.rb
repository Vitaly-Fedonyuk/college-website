class Admin::DashboardController < Admin::BaseController
  def index
    @news_count = News.count
    @recent_news = News.order(created_at: :desc).limit(5)
  end
end
