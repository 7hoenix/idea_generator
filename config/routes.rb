Rails.application.routes.draw do
  root 'site#landing'
  get "dashboard", to: "site#dashboard"
  get "profile", to: "site#profile"
  namespace :api do
    namespace :v1, defaults: { format: :json } do
      resources :possibilities, only: [:index]
    end
  end
end
