class PropertyIndoor < ApplicationRecord
  belongs_to :property

  enum kitchen: { not_enclosed: 0, enclosed: 1 }, _prefix: true
  enum living_room: { not_enclosed: 0, enclosed: 1 }, _prefix: true
  enum dinning_room: { not_enclosed: 0, enclosed: 1 }, _prefix: true
  enum maid_room: { miad_room_yes: 1 }, _prefix: true
  enum storage: { storage_yes: 1 }, _prefix: true
  enum guest_toilet: { guest_toilet_yes: 1 }, _prefix: true
end
