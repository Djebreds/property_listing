class PropertyRental < ApplicationRecord
  belongs_to :property

  has_many :property_rental_costs, dependent: :destroy

  accepts_nested_attributes_for :property_rental_costs, allow_destroy: true

  validates :property_id, uniqueness: { scope: :rental_type }

  enum rental_type: { daily: 1, monthly: 2, yearly: 3 }
end
