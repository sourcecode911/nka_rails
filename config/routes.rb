Rails.application.routes.draw do
  devise_for :users
  resources :residents

  get 'expenses', to: 'invoices#edit'

  resources :invoices
  # resources :users

  # resources :invoice_details

  root 'invoices#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
