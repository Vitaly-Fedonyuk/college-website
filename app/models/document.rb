class Document < ApplicationRecord
  has_one_attached :file
  
  validates :name, presence: true
  validates :category, presence: true
  
  # Categories for different pages
  CATEGORIES = {
    'Публічна інформація' => 'public_info',
    'Структурні підрозділи' => 'departments',
    'Моніторинг якості' => 'quality_monitoring'
  }.freeze
  
  scope :for_category, ->(category) { where(category: category) }
  scope :ordered, -> { order(created_at: :desc) }
end
