Rails.application.routes.draw do

  root   'pages#index'
  resources :orders
  resources :cake_prices
  resources :cakes
  resources :flavors
  resources :users
  resources :cake_orders
  
  get "/contacts/"=> "contacts#index"
  get "/pages/:page" => "pages#show"
  post   '/login'   => 'sessions#create'
  delete '/logout'  => 'sessions#destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
