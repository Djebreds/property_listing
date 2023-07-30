class PropertyCategory < ApplicationRecord
  has_many :properties, dependent: :destroy
  has_many :property_types, dependent: :destroy

  translates :name
  globalize_accessors locale: [:en, :id], attributes: [:name]

  before_save :translate_attributes

  private

  def translate_attributes
    I18n.locale = :en
    self.name_en = EasyTranslate.translate(self.name, to: :en, model: :nmt)

    I18n.locale = :id
    self.name_id = EasyTranslate.translate(self.name, to: :id, model: :nmt)
  end
end
