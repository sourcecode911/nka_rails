Rails.application.routes.draw do
  devise_for :users

  resources :invoices, only: [:index, :create, :update]
  get 'expenses', to: 'invoices#expenses'

  resources :flats
  resources :residents
  resources :users, only: [:update]

  # resources :invoice_details

  root 'invoices#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
