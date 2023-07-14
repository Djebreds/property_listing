class PropertyOutdoor < ApplicationRecord
  belongs_to :property

  enum swimming_pool: { yes: 1 }, _prefix: true
  enum garden: { yes: 1 }, _prefix: true
  enum balcony: { yes: 1 }, _prefix: true
end
