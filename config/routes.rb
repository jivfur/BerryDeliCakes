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
  
  post '/session/edit', to: 'sessions#edit'
  
  get "/contacts/"=> "contacts#index"
  get "/pages/:page" => "pages#show"
  post   '/login'   => 'sessions#create'
  get '/users/signout' => 'users#signout'
  post '/users/signout', to: 'users#signout'
  # get '/users/userlist' => 'users#index'
  # post '/users/userlist', to: 'users#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
