Rails.application.routes.draw do
  root 'site#landing'
  get "dashboard", to: "site#dashboard"
  post "dashboard", to: "site#create"
  get "profile", to: "site#profile"
  get "confirm", to: "site#confirm"

  get "/auth/twitter", as: :login
  get "/auth/twitter/callback", to: "sessions#create"
  get "logout", to: "sessions#destroy"

  namespace :api do
    namespace :v1, defaults: { format: :json } do
      resources :users, only: [:show]
      resources :possibilities, only: [:index]
      resources :lists, only: [:create]
      resources :ideas, only: [:create, :index, :destroy] do
        resources :tweets, only: [:create], module: "ideas"
        resources :possibilities, only: [:index], module: "ideas"
      end
      get "current_idea", to: "ideas#current"
      get "current", to: "users#current"
    end
  end
end
