Rails.application.routes.draw do
  get 'webpush_subscriptions', to: 'webpush_subscriptions#index'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :users

  resources :categories
  resources :transactions
  resources :wallets
  resources :reports
  resources :webpush_subscriptions
  get 'dashboard', to: 'dashboards#index'
end
