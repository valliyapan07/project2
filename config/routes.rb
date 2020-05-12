Rails.application.routes.draw do
  resources :menus
  resources :users
  resources :cartitems
  resources :orders
  get "/" => "home#index"
  delete "cartitems", to: "cartitems#deleteall"
  get "/sing-in" => "sessions#new", as: :new_sessions
  post "/sign_in", to: "sessions#create", as: :sessions
  delete "/signout" => "sessions#destroy", as: :destroy_session
end
