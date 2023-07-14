class PropertyType < ApplicationRecord
  belongs_to :property_category

  validates :property_category_id, uniqueness: { scope: :name }
end
