ActiveAdmin.register PropertyRequest do
  permit_params :first_name, :last_name, :email, :phone, :description, :property_category, :property_type

  before_save do |property_request|
    property_request.property_type = params[:property_request][:property_type].compact_blank
  end

  before_save do |property_request|
    property_request.property_category = params[:property_request][:property_category].compact_blank
  end

  batch_action :delete, confirm: I18n.t('active_admin.batch_action') do |ids|
    property_request = PropertyRequest.where(id: ids)
    property_request.destroy_all
    redirect_back(fallback_location: admin_root_path, notice: I18n.t('active_admin.batch_action_notice'))
  end

  filter :first_name
  filter :last_name
  filter :email
  filter :phone
  filter :property_category
  filter :property_type
  filter :created_at
  filter :updated_at

  index do
    selectable_column
    id_column
    column :first_name do |name|
      name.full_name
    end
    column :email
    column :phone
    column :description
    column :property_category
    column :property_type
    column :created_at
    column :updated_at

    actions
  end

  form data: { turbo: false } do |f|
    f.inputs do
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :phone
      f.input :description, as: :text, input_html: { rows: 2 }
      f.input :property_category, as: :select, collection: PropertyCategory.all.pluck(:name), input_html: { multiple: true }
      f.input :property_type, as: :select, collection: property_types, input_html: { multiple: true }
    end
    f.actions
  end

  controller do
    def property_types
      case I18n.locale
        when :en then ['villa', 'land', 'other']
        when :id then ['villa', 'tanah', 'lainnya']
      end
    end
  end
end
