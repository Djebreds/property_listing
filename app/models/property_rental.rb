class PropertyRental < ApplicationRecord
  belongs_to :property

  has_many :property_rental_costs, dependent: :destroy

  accepts_nested_attributes_for :property_rental_costs, allow_destroy: true

  monetize :price_cents, numericality: { greater_than_or_equal_to: 0 }, as: :price

  validates :rental_type, uniqueness: { scope: :property_id }

  enum rental_type: { daily: 1, monthly: 2, yearly: 3 }

  def display_price(currency)
    Money.new(self.price_cents, self.currency).exchange_to(currency).format
  end
end
