ActiveAdmin.register PropertyRental do
  belongs_to :property

  permit_params :rental_type, :price, :locale,
                property_rental_costs_attributes: %i[id name value _destroy]

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

  index do
    selectable_column
    id_column
    column t('active_admin.property.property_rental.rental'), :rental_type
    column t('active_admin.property.property_rental.price_currency'), :price_currency
    column t('active_admin.property.property_rental.price'), :price_cents do |price|
      price.display_price('IDR')
    end
    actions
  end

 show do
    attributes_table do
      row t('active_admin.property.property_rental.rental') do
        resource.rental_type
      end
      row t('active_admin.property.property_rental.price'), :price_cents do |price|
        price.display_price('IDR')
      end
      row t('active_admin.property.property_rental.price_currency') do
         resource.price_currency
      end
      row t('active_admin.property.created_at') do
        resource.created_at
      end
      row t('active_admin.property.updated_at') do
        resource.updated_at
      end
      panel 'Rental Cost' do
        table_for resource.property_rental_costs do
          column t('active_admin.property.property_rental.property_costs.name'), :name
          column t('active_admin.property.property_rental.property_costs.value'), :value
        end
      end
    end
  end

  form do |f|
    flash[:error]

    f.inputs do
      f.input :rental_type, label: t('active_admin.property.property_rental.rental'), as: :select
      f.input :price, label: t('active_admin.property.property_rental.price')

      panel '' do
        f.has_many :property_rental_costs, heading: 'Rental Costs', allow_destroy: true do |ff|
          ff.input :name, label: t('active_admin.property.property_rental.property_costs.name')
          ff.input :value, label: t('active_admin.property.property_rental.property_costs.value')
        end
      end
    end
    f.actions
  end
end
