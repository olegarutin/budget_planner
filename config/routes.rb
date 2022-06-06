Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :users

  resources :categories
  resources :transactions
  resources :wallets
  resources :dashboards
end
