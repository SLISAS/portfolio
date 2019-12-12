Rails.application.routes.draw do
  get "password_resets/new"
  get "password_resets/edit"
  get "sessions/new"
  get "users/new"
  root "static_pages#home"
  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  get "/show", to: "users#show"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get "/edit", to: "users#edit"
  resources :users
  resources :account_activations, only: %i[edit]
  resources :password_resets, only: %i[new create edit update]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
