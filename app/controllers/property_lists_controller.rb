class PropertyListsController < ApplicationController
  def index
    @properties = Property.includes(
                            property_rentals: :property_rental_costs,
                            property_kinds: :property_kind_costs)
                          .order(created_at: :desc)
                          .where(is_available: true)
                          .with_attached_images.page(params[:page]).per(15)
  end

  def detail
    @property = Property.includes(
                            property_rentals: [:translations, property_rental_costs: :translations],
                            property_kinds: [:translations, property_kind_costs: :translations])
                          .where(is_available: true)
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
                                 .with_attached_images
                                 .near([current_property.latitude, current_property.longitude], 30, units: :km)
                                 .where(is_available: true)
                                 .where(property_category: current_property.property_category)
                                 .where(property_type: current_property.property_type)
                                 .where.not(id: current_property.id).limit(3)
  end

  def search
    property_category = params[:property_category]
    property_type = params[:property_type]
    location = params[:location]

    @properties = Property.includes(
                            property_rentals: [:translations, property_rental_costs: :translations],
                            property_kinds: [:translations, property_kind_costs: :translations])
                          .with_translations(I18n.locale)
                          .where(is_available: true)
                          .order(created_at: :desc)
                          .with_attached_images

    return index if property_category.blank? && property_type.blank? && location.blank?

    @properties = @properties.where(property_category: property_category).page(params[:page]).per(15) if property_category.present?
    @properties = @properties.where(property_type: property_type).page(params[:page]).per(15) if property_type.present?
    @properties = @properties.where("location ILIKE ?", "%#{location}%").page(params[:page]).per(15) if location.present?
  end
end
