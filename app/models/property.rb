class Property < ApplicationRecord
  belongs_to :property_category
  belongs_to :property_type

  has_many :property_rentals, dependent: :destroy
  has_many :property_kinds, dependent: :destroy
  has_many :visitors, dependent: :destroy
  has_one :property_facility, dependent: :destroy
  has_one :property_general, dependent: :destroy
  has_one :property_indoor, dependent: :destroy
  has_one :property_outdoor, dependent: :destroy

  has_many_attached :images

  accepts_nested_attributes_for :property_facility, allow_destroy: true
  accepts_nested_attributes_for :property_general, allow_destroy: true
  accepts_nested_attributes_for :property_indoor, allow_destroy: true
  accepts_nested_attributes_for :property_outdoor, allow_destroy: true

  enum created_by: { admin: 0, marketing_officer: 1 }

  reverse_geocoded_by :latitude, :longitude
  geocoded_by :location

  validates :name, :latitude, :longitude, :property_type, :property_category,
            :location, :images, presence: true

  def counting_viewers
    viewers = Visitor.distinct.count(:ip_address)
  end

  def self.top_properties(limit = 3)
    joins(:visitors).group(:id).order(Arel.sql('COUNT(visitors.id) DESC')).limit(limit)
  end
end
