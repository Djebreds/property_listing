class PropertyOutdoor < ApplicationRecord
  belongs_to :property

  enum swimming_pool: { swimming_pool_yes: 1 }, _prefix: true
  enum garden: { garden_yes: 1 }, _prefix: true
  enum balcony: { balcony_yes: 1 }, _prefix: true
end
