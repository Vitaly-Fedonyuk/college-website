class News < ApplicationRecord
  has_one_attached :image
  
  validates :title, presence: true
  validates :content, presence: true
  
  scope :published, -> { where('published_at <= ?', Time.current).order(published_at: :desc) }
end
