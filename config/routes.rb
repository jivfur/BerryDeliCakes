Rails.application.routes.draw do

  root  'pages#index'
  #root 'users#index'
  
  
  resources :orders
  resources :cake_prices
  resources :cakes
  resources :flavors
  resources :users
  resources :cake_orders
  resources :sessions
  
  # post '/session/:id/edit', to: 'sessions#edit'
  post "/sessions/:id/edit"=> "sessions#edit"
  get "/sessions/:id/edit" => "sessions#edit"
  
  get "/cake_orders/:id/previous"=> "cake_orders#previous"
  post "/cake_orders/createOrder"=>"cake_orders#createOrder"
  
  get "/contacts/"=> "contacts#index"
  get "/pages/:page" => "pages#show"
  post   '/login'   => 'sessions#create'
  get '/users/signout' => 'users#signout'
  post '/users/signout', to: 'users#signout'
  #get '/sessions/admin_test' => 'sessions#admin_test'
  post '/sessions/admin_test', to: 'sessions#admin_test'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
