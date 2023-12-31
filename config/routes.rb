Rails.application.routes.draw do

  scope '(:locale)', defaults: { locale: I18n.default_locale } do
    devise_for :admin_users, ActiveAdmin::Devise.config
    ActiveAdmin.routes(self)
    get 'admin/property/property_type', to: 'property_types#index'

  end

  scope '(:locale)' do
    root to: 'home#index'
    get 'about', to: 'home#about'
    get 'contact', to: 'home#contact'
    get 'properties', to: 'property_lists#index'
    get 'properties/:property_category/:property_type/:id', to: 'property_lists#detail', as: :property
    get 'properties/search', to: 'property_lists#search', as: :properties_search
    post 'set_currency', to: 'currencies#set_currency', as: :set_currency
    get 'property-request/new-request', to: 'property_request#new_request'
    post 'property-request/send-request', to: 'property_request#send_request'
  end
end
