Rails.application.routes.draw do
  root "static_pages#home"

  get "/about", to: "static_pages#about"
  get "/contact", to: "static_pages#contact"
  get "/help", to: "static_pages#help"
  get "/signup", to: "users#new"
  get "/login", to: "sessions#new"

  post "/signup", to: "users#create"
  post "/login", to: "sessions#create"

  delete "/logout", to: "sessions#destroy"

  resources :posts do
    resources :comments
  end

  resources :users do
    member do
      get :following, :followers
    end
  end

  resources :users
  resources :posts, only: %i(create destroy)
  resources :comments, only: %i(create destroy)
  resources :relationships, only: %i(create destroy)
end
