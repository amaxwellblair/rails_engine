Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get "/merchants", to: "merchants#index"
      get "/merchants/:id", to: "merchants#show", as: "merchant"
      get "/customers", to: "customers#index"
      get "/customers/:id", to: "customers#show", as: "customer"
      get "/invoices", to: "invoices#index"
      get "/invoices/:id", to: "invoices#show", as: "invoice"
    end
  end
end
