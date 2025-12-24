class News < ApplicationRecord
  has_many_attached :images
  
  validates :title, presence: true
  validates :content, presence: true
  
  scope :published, -> { where('published_at <= ?', Time.current).order(published_at: :desc) }
  
  # Helper method to get the first image for preview
  def preview_image
    images.first
  end
end
