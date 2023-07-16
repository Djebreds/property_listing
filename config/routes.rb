Rails.application.routes.draw do

  scope '(:locale)', defaults: { locale: I18n.locale } do
    devise_for :admin_users, ActiveAdmin::Devise.config
    ActiveAdmin.routes(self)
    get '/google_map_places', to: 'google_maps_places#index', defaults: { format: 'json' }
  end

  scope "(:locale)", defaults: { locale: I18n.locale } do

    root 'home#index'
  end
end
