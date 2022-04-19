Rails.application.routes.draw do
  devise_for :users
  #delete 'users/sign_out', to: 'devise/sessions#destroy'

  resources :categories
  resources :transactions
  resources :users
  resources :wallets

end
