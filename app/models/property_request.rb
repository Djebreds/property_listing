class PropertyRequest < ApplicationRecord
  validates :first_name, :last_name, :email, :phone,
            :property_category, :property_type, :description, presence: true

  validates :phone, format: { with: /\A(628)(\d{7,14}$)\z/ }
end
