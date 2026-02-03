Rails.application.routes.draw do
  root "home#index"
   resources :items 
   resources :orders , only: [:index , :create, :show]
   resources :deliveries , only: [:index, :update, :show] do
     member do
       patch :assign
       patch :start_delivery
     end
   end
end
