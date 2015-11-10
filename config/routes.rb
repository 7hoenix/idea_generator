Rails.application.routes.draw do
  root 'site#landing'
  get "dashboard", to: "site#dashboard"
  get "profile", to: "site#profile"
end
