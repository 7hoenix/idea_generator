Rails.application.routes.draw do
  root 'site#landing'
  get "dashboard", to: "site#dashboard"
  post "dashboard", to: "site#create"
  get "profile", to: "site#profile"
  get "/auth/twitter/callback", to: "sessions#create"
  namespace :api do
    namespace :v1, defaults: { format: :json } do
      resources :users, only: [:show]
      resources :possibilities, only: [:index]
      resources :lists, only: [:create]
      resources :ideas, only: [:create, :index] do
        resources :tweets, only: [:create], module: "ideas"
        resources :possibilities, only: [:index], module: "ideas"
      end
    end
  end
end
