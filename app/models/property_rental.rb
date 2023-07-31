class PropertyRental < ApplicationRecord
  belongs_to :property

  has_many :property_rental_costs, dependent: :destroy

  accepts_nested_attributes_for :property_rental_costs, allow_destroy: true

  monetize :price_cents, numericality: { greater_than_or_equal_to: 0 }, as: :price

  validates :rental_type, :rental_type, presence: true
  validates :rental_type, uniqueness: { scope: :property_id }

  enum rental_type: { dailys: 1, monthly: 2, yearly: 3 }
  translates :rental_type
  globalize_accessors locale: [:en, :id], attributes: [:rental_type]

  include EnumTranslatable

  before_save :translate_attributes
  after_commit :update_property_availability, if: :persisted?

  def display_price(currency)
    Money.new(self.price_cents, self.currency).exchange_to(currency).format
  end

  def update_property_availability
    property.check_available
  end

  private

  def translate_attributes
    I18n.locale = :en
    self.rental_type_en = EasyTranslate.translate(self.rental_type, to: :en)

    I18n.locale = :id
    self.rental_type_id = EasyTranslate.translate(self.rental_type, to: :id)
  end
end
