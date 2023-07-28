class PropertyType < ApplicationRecord
  belongs_to :property_category

  validates :name, presence: true
end
