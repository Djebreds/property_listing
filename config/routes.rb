Rails.application.routes.draw do

  scope '(:locale)', defaults: { locale: I18n.locale } do
    devise_for :admin_users, ActiveAdmin::Devise.config
    ActiveAdmin.routes(self)
  end

  scope "(:locale)", defaults: { locale: I18n.locale } do
    resources :property_categories, only: [:index] do
      resources :property_types, only: [:index]
    end

    root 'home#index'
  end
end
