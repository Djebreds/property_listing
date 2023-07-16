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

  show do
    default_main_content do
      panel 'Rental Cost' do
        table_for resource.property_rental_costs, :name, :value
      end
    end
  end

  form do |f|
    flash[:error]

    f.inputs do
      f.input :rental_type, as: :select
      f.input :price

      panel '' do
        f.has_many :property_rental_costs, heading: 'Rental Costs', allow_destroy: true do |ff|
          ff.input :name
          ff.input :value
        end
      end
    end
    f.actions
  end
end