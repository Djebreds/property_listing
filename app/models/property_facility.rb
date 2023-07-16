class PropertyFacility < ApplicationRecord
  belongs_to :property

  enum furniture: { furnished: 1, not_furnished: 2 }
  enum internet: { fiber_optic: 1, wireless: 2 }
  enum parking: { closed: 1, opened: 2 }
  enum water_resource: { drilled_wells: 1, pdam: 2 }

  def electric_power_in_watt
    "#{electric_power} watt"
  end
end
