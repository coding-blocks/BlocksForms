Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  get 'home/index'

  root 'home#index'

  resources :forms
  resources :sections
  resources :questions

  get 'forms/:id/attempt' => 'attempts#new'
  post 'forms/:id/attempt' => 'attempts#create'
end
