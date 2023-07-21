ActiveAdmin.register PropertyRequest do
  permit_params :first_name, :last_name, :email, :phone, :description, :property_category, :property_type
end
