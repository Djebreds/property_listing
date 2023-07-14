ActiveAdmin.register Property do
  permit_params :name, :description, :property_category_id, :property_type_id, :available_on, images: [],
                property_facility_attributes: %i[id furniture electric_power water_resource internet parking _destroy],
                property_general_attributes: %i[id land_size building_size floor_level view style_design surrounding _destroy],
                property_indoor_attributes: %i[id living_room dinning_room kitchen bedroom ensuite_bathroom maid_room storage guest_toilet _destroy],
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


  form do |f|
    f.inputs do
      f.input :name
      f.input :property_type_id, as: :nested_select,
                                     level_1: { attribute: :property_category_id, collection: PropertyCategory.all },
                                     level_2: { attribute: :property_type_id, collection: PropertyType.all }
      f.input :available_on
      f.input :description, input_html: { rows: 2 }
      f.input :images, as: :file, input_html: { multiple: true }


      panel '' do
        f.has_many :property_general, class: 'has_one' do |ff|
          ff.input :land_size, label: 'Land size (m²)'
          ff.input :building_size, label: 'Building size (m²)'
          ff.input :floor_level
          ff.input :view
          ff.input :style_design, as: :select
          ff.input :surrounding
        end
      end

      panel '' do
        f.has_many :property_facility, class: 'has_one' do |ff|
          ff.input :furniture, as: :select
          ff.input :electric_power, label: 'Electric Power (watt)'
          ff.input :water_resource, as: :select
          ff.input :internet, as: :select
          ff.input :parking, as: :select
        end
      end

      panel '' do
        f.has_many :property_indoor, class: 'has_one' do |ff|
          ff.input :living_room, as: :select
          ff.input :dinning_room, as: :select
          ff.input :kitchen, as: :select
          ff.input :bedroom
          ff.input :ensuite_bathroom
          ff.input :maid_room, as: :select
          ff.input :storage, as: :select
          ff.input :guest_toilet, as: :select
        end
      end

      panel '' do
        f.has_many :property_outdoor, class: 'has_one' do |ff|
          ff.input :swimming_pool, as: :select
          ff.input :garden, as: :select
          ff.input :balcony, as: :select
        end
      end
    end
    actions
  end

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
        table_for resource.property_general, :land_size, :building_size, :floor_level, :view, :style_design, :surrounding
      end

      panel 'Indoor Information' do
        table_for resource.property_indoor, :living_room, :dinning_room, :kitchen, :bedroom, :ensuite_bathroom, :maid_room, :storage, :guest_toilet
      end

      panel 'Outdoor Information' do
        table_for resource.property_outdoor, :swimming_pool, :garden, :balcony
      end

      panel 'Facility Information' do
        table_for resource.property_facility, :furniture, :electric_power, :water_resource, :internet, :parking
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
