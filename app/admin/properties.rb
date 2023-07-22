ActiveAdmin.register Property do
  permit_params :name, :description, :property_category_id, :property_type_id, :locale,
                :available_on, :latitude, :longitude, :location, :note, images: [],
                property_facility_attributes: %i[id furniture electric_power water_resource internet parking _destroy],
                property_general_attributes: %i[id land_size building_size floor_level view style_design surrounding _destroy],
                property_indoor_attributes: %i[id living_room dinning_room kitchen bedroom bathroom ensuite_bathroom maid_room storage guest_toilet _destroy],
                property_outdoor_attributes: %i[id swimming_pool garden balcony _destroy]

  index do
    selectable_column
    id_column
    column :name
    column :created_at
    column :updated_at

    actions defaults: false do |property|
      links = ''.html_safe
      links += link_to I18n.t('active_admin.view'), admin_property_path(property, locale: I18n.locale), class: "member_link view_link"
      links += link_to I18n.t('active_admin.edit'), edit_admin_property_path(property, locale: I18n.locale), class: "member_link edit_link"
      links += link_to I18n.t('active_admin.delete'), admin_property_path(property, locale: I18n.locale), :method => :delete, :confirm => I18n.t('active_admin.delete_confirmation'), class: "member_link delete_link"
      links
    end
  end

  controller do
    def create
      super do |format|
        flash[:error] = resource.errors.full_messages.join(', ').html_safe if resource.errors.any?
      end
    end

    def update
      super do |format|
        flash[:error] = resource.errors.full_messages.join(', ').html_safe if resource.errors.any?
      end
    end
  end

  form partial: 'admin/form'

  action_item :add_property_general, only: [:edit, :new] do
    link_to "Add Property Rental", "", class: "btn", style: "display: none;"
  end

  show do
    default_main_content do
      row :images do
        div do
          property.images.each do |img|
            span do
              image_tag url_for(img), size: "150x150" if img.present?
            end
          end
        end
      end

      panel 'General Information' do
        table_for resource.property_general do
          column :land_size do |general|
            general.land_size_in_meter if general.present?
          end
          column :building_size do |general|
            general.building_size_in_meter if general.present?
          end
          column :floor_level
          column :view
          column :style_design
          column :surrounding
        end
      end

      panel 'Indoor Information' do
        table_for resource.property_indoor, :living_room, :dinning_room, :kitchen, :bedroom, :ensuite_bathroom, :maid_room, :storage, :guest_toilet
      end

      panel 'Outdoor Information' do
        table_for resource.property_outdoor, :swimming_pool, :garden, :balcony
      end

      panel 'Facility Information' do
        table_for resource.property_facility do
          column :furniture
          column :electric_power do |facility|
            facility.electric_power_in_watt if facility.present?
          end
          column :water_resource
          column :internet
          column :parking
        end
      end

      panel 'Property Kind' do
        table_for resource.property_kinds do
          column :kind do |property_kind|
            link_to property_kind.kind, admin_property_property_kind_path(property, property_kind, locale: I18n.locale)
          end
          column :price
          column 'Detail Costs' do |property_kind|
            link_to 'Detail Costs', admin_property_property_kind_path(property, property_kind, locale: I18n.locale)
          end
        end
      end

      panel 'Property Rental' do
        table_for resource.property_rentals do
          column :rental_type do |property_rental|
            property_rental.rental_type
          end
          column :price
          column 'Detail Costs' do |property_rental|
            link_to 'Detail Costs', admin_property_property_rental_path(property, property_rental, locale: I18n.locale)
          end
        end
      end

      panel 'Map' do
        div id: 'map', data: {
                      controller: 'get-place-google-maps',
                      action: "google-maps-callback@window->get-place-google-maps#initMap",
                      target: 'get-place-google-maps.map' }, style: 'width: 100%; height: 400px;' do
                        div data: { target: 'get-place-google-maps.latitude', 'get-place-google-maps-latitude-value': resource.latitude }
                        div data: { target: 'get-place-google-maps.longitude', 'get-place-google-maps-longitude-value': resource.longitude }
                      end
      end
    end
  end

  sidebar 'Property Kind', only: :show do
    ul do
      li link_to 'Kind', admin_property_property_kinds_path(property, locale: I18n.locale)
    end
  end

  sidebar 'Property Rental', only: :show do
    ul do
      li link_to 'Rental', admin_property_property_rentals_path(property, locale: I18n.locale)
    end
  end
end
