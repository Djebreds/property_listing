class PropertyRequest < ApplicationRecord
  validates :first_name, :last_name, :email, :description, :phone,
            :property_category, :property_type, presence: true
end
