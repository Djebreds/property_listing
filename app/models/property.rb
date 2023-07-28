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

  translates :name, :location, :note, :description
  globalize_accessors locale: [:en, :id], attributes: [:name, :location, :note, :description]

  validates :name, :latitude, :longitude, :property_type, :property_category,
            :location, :images, presence: true

  before_save :translate_attributes, :property_creation
  after_save :check_available

  def counting_viewers
    self.visitors.distinct.count(:ip_address)
  end

  def self.top_properties(limit = 3)
    joins(:visitors).group(:id).order(Arel.sql('COUNT(visitors.id) DESC')).limit(limit)
  end

  def check_available
    has_property_kinds = property_kinds.exists?
    has_property_rentals = property_rentals.exists?

    update_columns(is_available: has_property_kinds || has_property_rentals)
  end

  private

  def property_creation
    self.created_by = current_admin_user.role
    self.created_with = current_admin_user.name
  end

  def translate_attributes
    I18n.locale = :en
    self.name_en = EasyTranslate.translate(self.name, to: :en, model: :nmt)
    self.note_en = EasyTranslate.translate(self.note, to: :en, model: :nmt)
    self.description_en = EasyTranslate.translate(self.description, to: :en, model: :nmt)
    self.location_en = EasyTranslate.translate(self.location, to: :en, model: :nmt)

    I18n.locale = :id
    self.name_id = EasyTranslate.translate(self.name, to: :id, model: :nmt)
    self.note_id = EasyTranslate.translate(self.note, to: :id, model: :nmt)
    self.description_id = EasyTranslate.translate(self.description, to: :id, model: :nmt)
    self.location_id = EasyTranslate.translate(self.location, to: :id, model: :nmt)
  end
end
