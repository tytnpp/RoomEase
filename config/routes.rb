Rails.application.routes.draw do
  devise_for :users
  root "pages#home"

  resources :rooms, only: [:index, :show]
  resources :reservations, only: [:new, :create, :edit, :update, :destroy]

  # Placeholder routes for sidebar links
  get 'activity', to: 'reservations#activity'
  get 'profile', to: 'users#profile'
end