Rails.application.routes.draw do
  devise_for :users

  resources :categories
  resources :transactions
  resources :users
  resources :wallets
  resources :dashboards
end
