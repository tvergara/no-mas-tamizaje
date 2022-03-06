Rails.application.routes.draw do
  mount Sidekiq::Web => '/queue'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  root to: 'users#show'
  get '/edit', to: 'users#edit'
  patch '/', to: 'users#update'
end
