# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

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

# unless PropertyKind.any?
#   PropertyKind.create!([
#     {name: 'Freehold'},
#     {name: 'Leasehold'}
#   ])
# end

# unless PropertyRental.any?
#   PropertyRental.create!([
#     {name: 'daily'},
#     {name: 'monthly'},
#     {name: 'yearly'}
#   ])
# end

unless Property.any?
  Property.create!([
    {
      name: '3 BEDROOM VILLA FOR YEARLY RENTAL IN BALI NEAR BERAWA BEACH - RF1492',
      description: 'lorem ipsum dolor sit amet, consectetur adipiscing',
      available_on: DateTime.now,
      property_category_id: 2,
      property_type_id: 1
    }
  ])
end

