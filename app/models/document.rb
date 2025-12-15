class Document < ApplicationRecord
  has_one_attached :file
  
  validates :name, presence: true
end
