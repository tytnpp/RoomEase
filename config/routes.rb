Rails.application.routes.draw do
  devise_for :users
  root "rooms#index"

  resources :rooms do
    resources :reservations, only: [:new, :create, :destroy, :edit, :update] do
      member do
        get :cancel  # Add cancel route
      end
    end
  end
  
  # Placeholder routes for sidebar links
  get 'activity', to: 'reservations#activity'
end