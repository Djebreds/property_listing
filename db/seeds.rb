unless AdminUser.find_by(email: 'admin@example.com').present?
  AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
end

unless PropertyCategory.any?
PropertyCategory.create!([
  {name: 'Real Estate For Sale'},
  {name: 'Long Term Rentals'}
  ])
end

unless PropertyType.any?
  PropertyType.create!([
  {name: 'Villas', property_category_id: 1},
  {name: 'Land', property_category_id: 1},
  {name: 'Other', property_category_id: 1},
  {name: 'Villas', property_category_id: 2},
  {name: 'Other', property_category_id: 2}
])
end


