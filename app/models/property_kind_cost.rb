class PropertyKindCost < ApplicationRecord
  belongs_to :property_kind

  validates :name, :value, presence: true
end
