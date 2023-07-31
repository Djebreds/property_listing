ActiveAdmin.register Property do
  permit_params :name, :description, :property_category_id, :property_type_id, :locale,
                :latitude, :longitude, :location, :created_by, :created_with, :note, images: [],
                property_facility_attributes: %i[id furniture electric_power water_resource internet parking _destroy],
                property_general_attributes: %i[id land_size building_size floor_level view style_design surrounding _destroy],
                property_indoor_attributes: %i[id living_room dinning_room kitchen bedroom bathroom ensuite_bathroom maid_room storage guest_toilet _destroy],
                property_outdoor_attributes: %i[id swimming_pool garden balcony _destroy]


  filter :name
  filter :property_category_id, as: :select, collection: -> { PropertyCategory.all }
  filter :property_type_id, as: :select, collection: -> { [] }, input_html: { class: 'property-type-filter', id: 'type' }
  filter :created_by
  filter :created_with
  filter :is_available
  filter :created_at
  filter :updated_at

  batch_action :delete, confirm: I18n.t('active_admin.batch_action') do |ids|
    properties = Property.where(id: ids)
    properties.destroy_all
    redirect_back(fallback_location: admin_root_path, notice: I18n.t('active_admin.batch_action_notice'))
  end

  index do
    selectable_column
    id_column
    column t('active_admin.property.name'), :name
    column t('active_admin.property.property_category'), :property_category
    column t('active_admin.property.property_type'), :property_type
    column t('active_admin.property.created_by'), :created_by
    column t('active_admin.property.created_with'), :created_with
    column t('active_admin.property.is_available'), :is_available
    column t('active_admin.property.created_at'), :created_at
    column t('active_admin.property.updated_at'), :updated_at

    actions
  end

  form partial: 'admin/form'

  action_item :add_property_general, only: [:edit, :new] do
    link_to "Add Property Rental", "", class: "btn", style: "display: none;"
  end

  show do
    attributes_table do
      row t('active_admin.property.name') do
        resource.name
      end
      row t('active_admin.property.property_category') do
        resource.property_category
      end
      row t('active_admin.property.property_type') do
        resource.property_type
      end
      row t('active_admin.property.is_available') do
        resource.is_available
      end
      row :latitude
      row :longitude
      row t('active_admin.property.location') do
        resource.location
      end
      row t('active_admin.property.created_by') do
        resource.created_by
      end
      row t('active_admin.property.created_at') do
        resource.created_at
      end
      row t('active_admin.property.updated_at') do
        resource.updated_at
      end
      row t('active_admin.property.note') do
        resource.note
      end
      row t('active_admin.property.description') do
        resource.description
      end
      row t('active_admin.property.images') do
        div do
          property.images.each do |img|
            span do
              image_tag url_for(img), size: "150x150" if img.present?
            end
          end
        end
      end

      panel t('active_admin.property.property_general.name') do
        table_for resource.property_general do
          column t('active_admin.property.property_general.land_size'), :land_size do |general|
            if general.present?
              general.land_size_in_meter if general.land_size.present?
            end
          end
          column t('active_admin.property.property_general.building_size'), :building_size do |general|
            if general.present?
              general.building_size_in_meter if general.building_size?
            end
          end
          column t('active_admin.property.property_general.floor_level'), :floor_level
          column t('active_admin.property.property_general.view'), :view
          column t('active_admin.property.property_general.style_design'), :style_design do |general|
            if general.present?
              I18n.t("activerecord.attributes.property_general.style_designs.#{general.style_design}") if general.style_design.present?
            end
          end
          column t('active_admin.property.property_general.surrounding'), :surrounding
        end
      end

      panel t('active_admin.property.property_indoor.name') do
        table_for resource.property_indoor do
          column t('active_admin.property.property_indoor.living_room'), :living_room do |indoor|
            if indoor.present?
              I18n.t("activerecord.attributes.property_indoor.living_rooms.#{indoor.living_room}") if indoor.living_room.present?
            end
          end
          column t('active_admin.property.property_indoor.dinning_room'), :dinning_room do |indoor|
            if indoor.present?
              I18n.t("activerecord.attributes.property_indoor.dinning_rooms.#{indoor.dinning_room}") if indoor.dinning_room.present?
            end
          end
          column t('active_admin.property.property_indoor.kitchen'), :kitchen do |indoor|
            if indoor.present?
              I18n.t("activerecord.attributes.property_indoor.kitchens.#{indoor.kitchen}") if indoor.kitchen.present?
            end
          end
          column t('active_admin.property.property_indoor.bedroom'), :bedroom
          column t('active_admin.property.property_indoor.bathroom'), :bathroom
          column t('active_admin.property.property_indoor.ensuite_bathroom'), :ensuite_bathroom
          column t('active_admin.property.property_indoor.maid_room'), :maid_room do |indoor|
            if indoor.present?
              I18n.t("activerecord.attributes.property_indoor.maid_rooms.#{indoor.maid_room}") if indoor.maid_room.present?
            end
          end
          column t('active_admin.property.property_indoor.storage'), :storage do |indoor|
            if indoor.present?
              I18n.t("activerecord.attributes.property_indoor.storages.#{indoor.storage}") if indoor.storage.present?
            end
          end
          column t('active_admin.property.property_indoor.guest_toilet'), :guest_toilet do |indoor|
            if indoor.present?
              I18n.t("activerecord.attributes.property_indoor.guest_toilet.#{indoor.guest_toilet}") if indoor.guest_toilet.present?
            end
          end
        end
      end

      panel t('active_admin.property.property_outdoor.name') do
        table_for resource.property_outdoor do
          column t('active_admin.property.property_outdoor.swimming_pool'), :swimming_pool do |outdoor|
            if outdoor.present?
              I18n.t("activerecord.attributes.property_outdoor.swimming_pool.#{outdoor.swimming_pool}") if outdoor.swimming_pool.present?
            end
          end
          column t('active_admin.property.property_outdoor.garden'), :garden do |outdoor|
            if outdoor.present?
              I18n.t("activerecord.attributes.property_outdoor.garden.#{outdoor.garden}") if outdoor.garden.present?
            end
          end
          column t('active_admin.property.property_outdoor.balcony'), :balcony do |outdoor|
            if outdoor.present?
              I18n.t("activerecord.attributes.property_outdoor.balcony.#{outdoor.balcony}") if outdoor.balcony.present?
            end
          end
        end
      end

      panel t('active_admin.property.property_facility.name') do
        table_for resource.property_facility do
          column t('active_admin.property.property_facility.furniture'), :furniture do |facility|
            if facility.present?
              I18n.t("activerecord.attributes.property_facility.furnitures.#{facility.furniture}") if facility.furniture.present?
            end
          end
          column t('active_admin.property.property_facility.electric_power'), :electric_power do |facility|
            if facility.present?
              facility.electric_power_in_watt if facility.electric_power.present?
            end
          end
          column t('active_admin.property.property_facility.water_resource'), :water_resource do |facility|
            if facility.present?
              I18n.t("activerecord.attributes.property_facility.water_resources.#{facility.water_resource}") if facility.water_resource.present?
            end
          end
          column t('active_admin.property.property_facility.internet'), :internet do |facility|
            if facility.present?
              I18n.t("activerecord.attributes.property_facility.internets.#{facility.internet}") if facility.internet.present?
            end
          end
          column t('active_admin.property.property_facility.parking'), :parking do |facility|
            if facility.present?
              I18n.t("activerecord.attributes.property_facility.parkings.#{facility.parking}") if facility.parking.present?
            end
          end
        end
      end

      panel t('active_admin.property.property_kind.name') do
        table_for resource.property_kinds do
          column t('active_admin.property.property_kind.kind'), :kind
          column t('active_admin.property.property_kind.price'), :price do |p|
            p.display_price('IDR')
          end
          column t('active_admin.property.property_kind.property_costs.detail_cost') do |property_kind|
            link_to t('active_admin.property.property_kind.property_costs.detail_cost'), admin_property_property_kind_path(property, property_kind, locale: I18n.locale)
          end
        end
      end

      panel t('active_admin.property.property_rental.name') do
        table_for resource.property_rentals do
          column t('active_admin.property.property_rental.rental'), :rental_type
          column t('active_admin.property.property_rental.price'), :price do |p|
            p.display_price('IDR')
          end
          column t('active_admin.property.property_rental.property_costs.detail_cost') do |property_rental|
            link_to t('active_admin.property.property_rental.property_costs.detail_cost'), admin_property_property_rental_path(property, property_rental, locale: I18n.locale)
          end
        end
      end

      panel 'Map' do
        div id: 'map', data: {
                      controller: 'get-place-google-maps',
                      action: "google-maps-callback@window->get-place-google-maps#initMap",
                      target: 'get-place-google-maps.latitude', 'get-place-google-maps-latitude-value': resource.latitude,
                      target: 'get-place-google-maps.longitude', 'get-place-google-maps-longitude-value': resource.longitude,
                      target: 'get-place-google-maps.map' }, style: 'width: 100%; height: 400px;'
      end
    end
  end

  sidebar 'Property Kind', only: :show do
    ul do
      li link_to t('active_admin.property.property_kind.kind'), admin_property_property_kinds_path(property, locale: I18n.locale)
    end
  end

  sidebar 'Property Rental', only: :show do
    ul do
      li link_to t('active_admin.property.property_rental.rental'), admin_property_property_rentals_path(property, locale: I18n.locale)
    end
  end
end
