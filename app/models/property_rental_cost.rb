class PropertyRentalCost < ApplicationRecord
  belongs_to :property_rental

  validates :name, :value, presence: true
end
