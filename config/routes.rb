Rails.application.routes.draw do
  resources :menus
  resources :users do
    member do
      get :confirm_email
    end
  end
  resources :cartitems
  resources :orders
  resources :userhome
  resources :pendingorders
  resources :menuitems
  get "orders/report", to: "orders#report"
  get "menuitems/hold", to: "menuitems#hold"
  patch "users/select", to: "users#select"
  patch "users/details", to: "users#details"
  get "users/checkers", to: "users#show", as: :checkers
  post "orders/hold", to: "orders#hold"
  post "orders/select", to: "orders#select"
  get "/" => "home#index"
  delete "cartitems", to: "cartitems#deleteall"
  get "/sing-in" => "sessions#new", as: :new_sessions
  post "/sign_in", to: "sessions#create", as: :sessions
  delete "/signout" => "sessions#destroy", as: :destroy_session
end
