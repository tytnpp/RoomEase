Rails.application.routes.draw do
  devise_for :users
  root "pages#home"

  resources :rooms, only: [:index, :show]
  resources :reservations, only: [:new, :create]
end
