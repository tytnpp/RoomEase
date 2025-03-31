Rails.application.routes.draw do
  devise_for :users
  root "pages#home"

  resources :rooms, only: [:index, :show] do
    resources :reservations, only: [:new, :create, :edit, :update, :destroy]
  end

  # Placeholder routes for sidebar links
  get 'activity', to: 'reservations#activity'
end