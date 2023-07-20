class PropertyKind < ApplicationRecord
  belongs_to :property

  has_many :property_kind_costs, dependent: :destroy

  accepts_nested_attributes_for :property_kind_costs, allow_destroy: true

  monetize :price_cents, numericality: { greater_than_or_equal_to: 0 }, as: :price

  validates :kind, uniqueness: { scope: :property_id }

  enum kind: { freehold: 1, leasehold: 2 }

  def display_price(currency)
    Money.new(self.price_cents, self.currency).exchange_to(currency).format
  end
end
