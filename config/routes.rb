Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get "/merchants", to: "merchants#index"
      get "/merchants/find", to: "merchants#find", as: "find_merchant"
      get "/merchants/find_all", to: "merchants#find_all", as: "find_all_merchants"
      get "/merchants/:id", to: "merchants#show", as: "merchant"

      get "/customers", to: "customers#index"
      get "/customers/find", to: "customers#find", as: "find_customer"
      get "/customers/find_all", to: "customers#find_all", as: "find_all_customers"
      get "/customers/:id", to: "customers#show", as: "customer"

      get "/invoices", to: "invoices#index"
      get "/invoices/:id", to: "invoices#show", as: "invoice"

      get "/items", to: "items#index"
      get "/items/:id", to: "items#show", as: "item"

      get "/invoice_items/", to: "invoice_items#index"
      get "/invoice_items/:id", to: "invoice_items#show", as: "invoice_item"

      get "/transactions", to: "transactions#index"
      get "/transactions/:id", to: "transactions#show", as: "transaction"
    end
  end
end
