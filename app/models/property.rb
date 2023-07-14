class Property < ApplicationRecord
  belongs_to :property_category
  belongs_to :property_type

  has_many :property_rentals, dependent: :destroy
  has_many :property_kinds, dependent: :destroy
  has_one :property_facility, dependent: :destroy
  has_one :property_general, dependent: :destroy
  has_one :property_indoor, dependent: :destroy
  has_one :property_outdoor, dependent: :destroy
  has_one :property_location, dependent: :destroy

  has_many_attached :images

  accepts_nested_attributes_for :property_facility, allow_destroy: false
  accepts_nested_attributes_for :property_general, allow_destroy: false
  accepts_nested_attributes_for :property_indoor, allow_destroy: false
  accepts_nested_attributes_for :property_outdoor, allow_destroy: false

  enum created_by: { admin: 0, marketing_officer: 1 }
end
