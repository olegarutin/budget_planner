Rails.application.routes.draw do
  get 'notifications/index'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :users

  resources :categories
  resources :transactions
  resources :wallets
  resources :dashboards
  resources :reports
  resources :notifications
end
