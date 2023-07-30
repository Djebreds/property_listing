
unless AdminUser.any?
  AdminUser.create!(name: 'Admin', email: 'admin@propertylist.com', password: 'password', password_confirmation: 'password', role: :admin)
  AdminUser.create!(name: 'Marketing Officer', email: 'marketing@propertylist.com', password: 'password', password_confirmation: 'password', role: :marketing_officer)
end

unless PropertyCategory.any?
  PropertyCategory.create!([
    {name: 'Real Estate For Sale'},
    {name: 'Long Term Rentals'}
  ])
end

unless PropertyType.any?
  PropertyType.create!([
    {name: 'Villa', property_category_id: 1},
    {name: 'Land', property_category_id: 1},
    {name: 'Other', property_category_id: 1},
    {name: 'Villa', property_category_id: 2},
    {name: 'Other', property_category_id: 2}
  ])
end
