class PropertyKind < ApplicationRecord
  belongs_to :property

  has_many :property_kind_costs, dependent: :destroy

  accepts_nested_attributes_for :property_kind_costs, allow_destroy: true

  monetize :price_cents, numericality: { greater_than_or_equal_to: 0 }, as: :price

  validates :kind, :price, presence: true
  validates :kind, uniqueness: { scope: :property_id }

  enum kind: { freehold: 1, leasehold: 2 }
  translates :kind
  globalize_accessors locale: [:en, :id], attributes: [:kind]

  before_save :translate_attributes
  after_commit :update_property_availability

  def display_price(currency)
    Money.new(self.price_cents, self.currency).exchange_to(currency).format
  end

  def update_property_availability
    property.check_available
  end

  private

  def translate_attributes
    I18n.locale = :en
    self.kind_en = EasyTranslate.translate(self.kind, to: :en, model: :nmt)

    I18n.locale = :id
    self.kind_id = EasyTranslate.translate(self.kind, to: :id, model: :nmt)
  end
end
