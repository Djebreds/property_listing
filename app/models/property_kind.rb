class PropertyKind < ApplicationRecord
  belongs_to :property

  has_many :property_kind_costs, dependent: :destroy

  accepts_nested_attributes_for :property_kind_costs, allow_destroy: true

  validates :property_id, uniqueness: { scope: :kind }

  enum kind: { freehold: 1, leasehold: 2 }
end
