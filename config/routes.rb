Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get "/merchants", to: "merchants#index"
      get "/merchants/:id", to: "merchants#show", as: "merchant"
      get "/customers", to: "customers#index"
      get "/customers/:id", to: "customers#show", as: "customer"
    end
  end
end
