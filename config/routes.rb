Rails.application.routes.draw do
  root 'site#landing'
  get "dashboard", to: "site#dashboard"
end
