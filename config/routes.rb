Rails.application.routes.draw do
  devise_for :users
  resources :residents

  get 'expenses', to: 'invoices#expenses'

  resources :invoices
  resources :users, only: [:update]

  # resources :invoice_details

  root 'invoices#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
