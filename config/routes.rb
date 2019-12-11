Rails.application.routes.draw do
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

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
