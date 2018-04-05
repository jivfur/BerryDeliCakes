Rails.application.routes.draw do


  resources :orders
  resources :cake_prices
  resources :cakes
  resources :flavors
  resources :users
  
  get "/pages/:page" => "pages#show"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
