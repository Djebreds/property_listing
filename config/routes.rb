Rails.application.routes.draw do

  scope '(:locale)', defaults: { locale: I18n.locale } do
    devise_for :admin_users, ActiveAdmin::Devise.config
    ActiveAdmin.routes(self)

  end

  scope '(:locale)' do
    root to: 'home#index'
    get '/about', to: 'home#about'
    get '/contact', to: 'home#contact'
  end
end
