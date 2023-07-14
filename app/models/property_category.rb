class PropertyCategory < ApplicationRecord
  has_many :properties, dependent: :destroy
  has_many :property_types, dependent: :destroy

  accepts_nested_attributes_for :property_types
end
