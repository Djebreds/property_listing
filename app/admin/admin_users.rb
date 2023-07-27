ActiveAdmin.register AdminUser do
  permit_params :email, :name, :password, :password_confirmation, :role, :locale

  index do
    selectable_column
    id_column
    column t('active_admin.name'), :name
    column t('active_admin.email'), :email
    column t('active_admin.role'), :role
    column t('active_admin.current_sign_in_at'), :current_sign_in_at
    column t('active_admin.sign_in_count'), :sign_in_count
    column t('active_admin.created_at'), :created_at

    actions
  end

  filter :name
  filter :email
  filter :role
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs do
      f.input :name, label: t('active_admin.name')
      f.input :email, label: t('active_admin.email')
      f.input :password
      f.input :password_confirmation
      f.input :role, label: t('active_admin.role'), as: :select
    end
    f.actions
  end
end
