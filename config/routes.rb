Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  get 'home/index'

  root 'home#index'

  resources :forms
  resources :sections
  resources :questions
end
