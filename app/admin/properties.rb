ActiveAdmin.register Property do
  permit_params :name, :description, :property_category_id, :property_type_id, :locale,
                :latitude, :longitude, :location, :note, images: [],
                property_facility_attributes: %i[id furniture electric_power water_resource internet parking _destroy],
                property_general_attributes: %i[id land_size building_size floor_level view style_design surrounding _destroy],
                property_indoor_attributes: %i[id living_room dinning_room kitchen bedroom bathroom ensuite_bathroom maid_room storage guest_toilet _destroy],
                property_outdoor_attributes: %i[id swimming_pool garden balcony _destroy]

  index do
    selectable_column
    id_column
    column :name
    column :property_category
    column :property_type
    column :created_at
    column :updated_at

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
            general.land_size_in_meter if general.present?
          end
          column t('active_admin.property.property_general.building_size'), :building_size do |general|
            general.building_size_in_meter if general.present?
          end
          column t('active_admin.property.property_general.floor_level'), :floor_level
          column t('active_admin.property.property_general.view'), :view
          column t('active_admin.property.property_general.style_design'), :style_design
          column t('active_admin.property.property_general.surrounding'), :surrounding
        end
      end

      panel t('active_admin.property.property_indoor.name') do
        table_for resource.property_indoor do
          column t('active_admin.property.property_indoor.living_room'), :living_room
          column t('active_admin.property.property_indoor.dinning_room'), :dinning_room
          column t('active_admin.property.property_indoor.kitchen'), :kitchen
          column t('active_admin.property.property_indoor.bedroom'), :bedroom
          column t('active_admin.property.property_indoor.bathroom'), :bathroom
          column t('active_admin.property.property_indoor.ensuite_bathroom'), :ensuite_bathroom
          column t('active_admin.property.property_indoor.maid_room'), :maid_room
          column t('active_admin.property.property_indoor.storage'), :storage
          column t('active_admin.property.property_indoor.guest_toilet'), :guest_toilet
        end
      end

      panel t('active_admin.property.property_outdoor.name') do
        table_for resource.property_outdoor do
          column t('active_admin.property.property_outdoor.swimming_pool'), :swimming_pool
          column t('active_admin.property.property_outdoor.garden'), :garden
          column t('active_admin.property.property_outdoor.balcony'), :balcony
        end
      end

      panel t('active_admin.property.property_facility.name') do
        table_for resource.property_facility do
          column t('active_admin.property.property_facility.furniture'), :furniture
          column t('active_admin.property.property_facility.electric_power'), :electric_power do |facility|
            facility.electric_power_in_watt if facility.present?
          end
          column t('active_admin.property.property_facility.water_resource'), :water_resource
          column t('active_admin.property.property_facility.internet'), :internet
          column t('active_admin.property.property_facility.parking'), :parking
        end
      end

      panel t('active_admin.property.property_kind.name') do
        table_for resource.property_kinds do
          column t('active_admin.property.property_kind.kind'), :kind do |property_kind|
            link_to property_kind.kind, admin_property_property_kind_path(property, property_kind, locale: I18n.locale)
          end
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
          column t('active_admin.property.property_rental.rental'), :rental_type do |property_rental|
            property_rental.rental_type
          end
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
