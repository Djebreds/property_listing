class PropertyIndoor < ApplicationRecord
  belongs_to :property

  enum kitchen: { not_enclosed: 0, enclosed: 1 }, _prefix: true
  enum living_room: { not_enclosed: 0, enclosed: 1 }, _prefix: true
  enum dinning_room: { not_enclosed: 0, enclosed: 1 }, _prefix: true
  enum maid_room: { yes: 1 }, _prefix: true
  enum storage: { yes: 1 }, _prefix: true
  enum guest_toilet: { yes: 1 }, _prefix: true
end
