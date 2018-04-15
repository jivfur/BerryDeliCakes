Rails.application.routes.draw do

  #root   'pages#index'
  root 'users#index'
  
  resources :orders
  resources :cake_prices
  resources :cakes
  resources :flavors
  resources :users
  resources :cake_orders
  resources :sessions
  
  get "/contacts/"=> "contacts#index"
  get "/pages/:page" => "pages#show"
  post   '/login'   => 'sessions#create'
  delete '/logout'  => 'sessions#destroy'
  get '/users/signout' => 'users#signout'
  post '/users/signout', to: 'users#signout'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
