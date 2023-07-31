class PropertyRequest < ApplicationRecord
  validates :first_name, :last_name, :email, :phone,
            :property_category, :property_type, :description, presence: true

  validates :phone, format: { with: /\A(628)(\d{7,14}$)\z/ }

  translates :description, :property_type, :property_category
  globalize_accessors locale: [:en, :id], attributes: [:description, :property_type, :property_category]

  before_save :translate_attributes

  def full_name
    "#{first_name} #{last_name}".capitalize
  end

  private

  def translate_attributes
    I18n.locale = :en
    self.description_en = EasyTranslate.translate(self.description, to: :en, model: :nmt)
    self.property_type_en = EasyTranslate.translate(self.property_type, to: :en, model: :nmt)
    self.property_category_en = EasyTranslate.translate(self.property_category, to: :en, model: :nmt)

    I18n.locale = :id
    self.description_id = EasyTranslate.translate(self.description, to: :id, model: :nmt)
    self.property_type_id = EasyTranslate.translate(self.property_type, to: :id, model: :nmt)
    self.property_category_id = EasyTranslate.translate(self.property_category, to: :id, model: :nmt)
  end
end
