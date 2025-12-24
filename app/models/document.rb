class Document < ApplicationRecord
  has_one_attached :file
  
  validates :name, presence: true
  validates :category, presence: true
  
  # Categories for different pages
  CATEGORIES = {
    'public_info' => 'Публічна інформація',
    'departments' => 'Структурні підрозділи',
    'quality_monitoring' => 'Моніторинг якості'
  }.freeze
  
  scope :for_category, ->(category) { where(category: category) }
  scope :ordered, -> { order(created_at: :desc) }
end
