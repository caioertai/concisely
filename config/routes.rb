Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :lessons, only: [ :index, :new, :create, :edit, :update, :destroy ] do
    resources :bookings, only: [ :new, :create, ]
  end
  
  resources :bookings, only: [ :show, :edit, :update ]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
