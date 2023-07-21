class HomeController < ApplicationController
  def index
    @properties = Property.includes(
                            property_rentals: :property_rental_costs,
                            property_kinds: :property_kind_costs)
                          .with_attached_images.order('created_at').limit(6)

    @top_properties = Property.top_properties(5)
  end

  def about; end
  def contact; end
end
