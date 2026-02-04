Rails.application.routes.draw do
  root "home#index"
  get 'set_role', to: 'home#set_role'
  
  resources :categories, only: [:index, :new, :create, :destroy]
  resources :items, only: [:index, :new, :create, :destroy, :edit, :update]
  resources :orders , only: [:index , :create, :show]
  resources :deliveries , only: [:index, :update, :show] do
    member do
      patch :assign
      patch :pickup
      patch :start_delivery
      patch :nearby
    end
  end
end
