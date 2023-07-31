class HomeController < ApplicationController
  def index
    @properties = Property.includes(
                            property_rentals: :property_rental_costs,
                            property_kinds: :property_kind_costs)
                          .where(is_available: true)
                          .with_attached_images.order(created_at: :desc).limit(6)

    @top_properties = Property.includes(
                            property_rentals: :property_rental_costs,
                            property_kinds: :property_kind_costs)
                          .where(is_available: true)
                          .with_attached_images.order(created_at: :desc).limit(5)
  end

  def about; end
  def contact; end
end
