Rails.application.routes.draw do

  scope ':locale', defaults: { locale: I18n.locale } do
    devise_for :admin_users, ActiveAdmin::Devise.config
    ActiveAdmin.routes(self)
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "articles#index"

  scope ":locale", locale: /en|id/ do
    root 'home#index'
  end
end
