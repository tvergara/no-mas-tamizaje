Rails.application.routes.draw do
  mount Sidekiq::Web => '/queue'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  resources :users, only: [:show, :edit, :update]
  root to: 'users#show'
end
