class PropertyGeneral < ApplicationRecord
  belongs_to :property

  validates :land_size, :building_size, format: { with: /\d/ }

  enum style_design: { modern: 1, classic: 2 }

  translates :view, :surrounding
  globalize_accessors locale: [:en, :id], attributes: [:view, :surrounding]

  before_save :translate_attributes


  def land_size_in_meter
    "#{land_size} m²"
  end

  def building_size_in_meter
    "#{building_size} m²"
  end

  private

  def translate_attributes
    I18n.locale = :en
    self.view_en = EasyTranslate.translate(self.view, to: :en, model: :nmt)
    self.surrounding_en = EasyTranslate.translate(self.surrounding, to: :en, model: :nmt)

    I18n.locale = :id
    self.view_id = EasyTranslate.translate(self.view, to: :id, model: :nmt)
    self.surrounding_id = EasyTranslate.translate(self.surrounding, to: :id, model: :nmt)
  end
end
