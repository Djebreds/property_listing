class PropertyListsController < ApplicationController
  def index
    @properties = Property.includes(
                            property_rentals: :property_rental_costs,
                            property_kinds: :property_kind_costs)
                          .with_attached_images
  end

  def detail
    @property = Property.includes(
                            property_rentals: :property_rental_costs,
                            property_kinds: :property_kind_costs)
                          .with_attached_images.find(params[:id])

    visitor = @property.visitors.create(ip_address: request.remote_ip)
    @viewers = @property.counting_viewers

    @similar_properties = similar_properties
  end

  def similar_properties
    current_property = Property.find(params[:id])

    similar_properties = Property.includes(
                                    property_rentals: :property_rental_costs,
                                    property_kinds: :property_kind_costs)
                                 .with_attached_images.near([current_property.latitude, current_property.longitude], 30, units: :km)
                                 .where(property_category: current_property.property_category)
                                 .where(property_type: current_property.property_type)
                                 .where.not(id: current_property.id).limit(3)
  end

  def search
    property_category = params[:property_category]
    property_type = params[:property_type]
    location = params[:location]

    @properties = Property.includes(
                            property_rentals: :property_rental_costs,
                            property_kinds: :property_kind_costs)
                          .with_attached_images

    @properties = @properties.where(property_category: property_category) if property_category.present?
    @properties = @properties.where(property_type: property_type) if property_type.present?
    @properties = @properties.where("location ILIKE ?", "%#{location}%") if location.present?
  end
end
