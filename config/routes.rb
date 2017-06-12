Rails.application.routes.draw do
  devise_for :users

  resources :invoices, only: [:index, :create, :update, :show] do
    get 'expenses', on: :collection
    get 'counts', on: :collection
    get 'finalize', on: :member
  end
  resources :counts, only: :new

  resources :flats
  resources :residents
  resources :users, only: [:update]
  resources :meters

  # resources :invoice_details

  root 'invoices#counts'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
