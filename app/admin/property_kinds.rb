ActiveAdmin.register PropertyKind do
  belongs_to :property

  permit_params :kind, :price, :locale,
                property_kind_costs_attributes: %i[id name value _destroy]

  index do
    selectable_column
    id_column
    column t('active_admin.property.property_kind.kind'), :kind
    column t('active_admin.property.property_kind.price_currency'), :price_currency
    column t('active_admin.property.property_kind.price'), :price_cents do |price|
      price.display_price('IDR')
    end
    actions
  end

  show do
    attributes_table do
      row t('active_admin.property.property_kind.kind') do
        resource.kind
      end
      row t('active_admin.property.property_kind.price'), :price_cents do |price|
        price.display_price('IDR')
      end
      row t('active_admin.property.property_kind.price_currency') do
         resource.price_currency
      end
      row t('active_admin.property.created_at') do
        resource.created_at
      end
      row t('active_admin.property.updated_at') do
        resource.updated_at
      end
      panel 'Kind Cost' do
        table_for resource.property_kind_costs do
          column t('active_admin.property.property_kind.property_costs.name'), :name
          column t('active_admin.property.property_kind.property_costs.value'), :value
        end
      end
    end
  end

  form data: { turbo: false } do |f|
    f.inputs do
      f.input :kind, label: t('active_admin.property.property_kind.kind'), as: :select
      f.input :price, label: t('active_admin.property.property_kind.price')

      panel '' do
        f.has_many :property_kind_costs, heading: 'Kind Costs', allow_destroy: true do |ff|
          ff.input :name, label: t('active_admin.property.property_kind.property_costs.name')
          ff.input :value, label: t('active_admin.property.property_kind.property_costs.value')
        end
      end
    end
    f.actions
  end
end
