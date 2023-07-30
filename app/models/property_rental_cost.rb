class PropertyRentalCost < ApplicationRecord
  belongs_to :property_rental

  validates :name, :value, presence: true
  translates :name, :value
  globalize_accessors locale: [:en, :id], attributes: [:name, :value]

  before_save :translate_attributes

  private

  def translate_attributes
    I18n.locale = :en
    self.name_en = EasyTranslate.translate(self.name, to: :en, model: :nmt)
    self.value_en = EasyTranslate.translate(self.value, to: :en, model: :nmt)

    I18n.locale = :id
    self.name_id = EasyTranslate.translate(self.name, to: :id, model: :nmt)
    self.value_id = EasyTranslate.translate(self.value, to: :id, model: :nmt)
  end
end
