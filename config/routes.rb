Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get "/merchants", to: "merchants#index"
      get "/merchants/:id", to: "merchants#show", as: "merchant"
      get "/customers", to: "customers#index"
      get "/customers/:id", to: "customers#show", as: "customer"
      get "/invoices", to: "invoices#index"
      get "/invoices/:id", to: "invoices#show", as: "invoice"
      get "/items", to: "items#index"
      get "/items/:id", to: "items#show", as: "item"
      get "/invoice_items/", to: "invoice_items#index"
      get "/invoice_items/:id", to: "invoice_items#show", as: "invoice_item"
    end
  end
end
