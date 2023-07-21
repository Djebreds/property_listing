class SearchPropertiesController < ApplicationController
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
    # @properties = Property.where(category: params[:property_category],
    #                              property_type: params[:property_type])
    #                       .where("location ILIKE ?", "%#{params[:location]}%")

    # property_category = params[:property_category]
    # property_type = params[:property_type]
    # location = params[:location]

    # @properties = Property.includes(
    #                         property_rentals: :property_rental_costs,
    #                         property_kinds: :property_kind_costs)
    #                       .with_attached_images

    # if property_category.present? && property_type.present?
    #   @properties = Property.where(property_category: params[:property_category],
    #                                property_type: params[:property_type])
    #                         .where("location ILIKE ?", "%#{params[:location]}%")
    # elsif property_category.present?
    #   @properties = Property.where(property_category: params[:property_category])
    #                         .where("location ILIKE ?", "%#{params[:location]}%")
    # elsif property_type.present?
    #   @properties = Property.where(property_type: params[:property_type])
    #                         .where("location ILIKE ?", "%#{params[:location]}")
    # end
  end
end
