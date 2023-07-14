class PropertyGeneral < ApplicationRecord
  belongs_to :property

  validates :land_size, :building_size, format: { with: /\d/ }

  enum style_design: { modern: 1, classic: 2 }

  def land_size_meter
    "#{land_size} m²"
  end

  def building_size_meter
    "#{building_size} m²"
  end
end
