Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get "/merchants", to: "merchants#index"
      get "/merchants/find", to: "merchants#find", as: "find_merchant"
      get "/merchants/find_all", to: "merchants#find_all", as: "find_all_merchants"
      get "/merchants/random", to: "merchants#random", as: "random_merchant"
      get "/merchants/:id", to: "merchants#show", as: "merchant"

      get "/customers", to: "customers#index"
      get "/customers/find", to: "customers#find", as: "find_customer"
      get "/customers/find_all", to: "customers#find_all", as: "find_all_customers"
      get "/customers/random", to: "customers#random", as: "random_customer"
      get "/customers/:id", to: "customers#show", as: "customer"

      get "/invoices", to: "invoices#index"
      get "/invoices/find", to: "invoices#find", as: "find_invoice"
      get "/invoices/find_all", to: "invoices#find_all", as: "find_all_invoices"
      get "/invoices/:id", to: "invoices#show", as: "invoice"

      get "/items", to: "items#index"
      get "/items/find", to: "items#find", as: "find_item"
      get "/items/find_all", to: "items#find_all", as: "find_all_items"
      get "/items/random", to: "items#random", as: "random_item"
      get "/items/:id", to: "items#show", as: "item"


      get "/invoice_items/", to: "invoice_items#index"
      get "/invoice_items/find", to: "invoice_items#find", as: "find_invoice_item"
      get "/invoice_items/find_all", to: "invoice_items#find_all", as: "find_all_invoice_items"
      get "/invoice_items/:id", to: "invoice_items#show", as: "invoice_item"

      get "/transactions", to: "transactions#index"
      get "/transactions/find", to: "transactions#find", as: "find_transaction"
      get "/transactions/find_all", to: "transactions#find_all", as: "find_all_transactions"
      get "/transactions/:id", to: "transactions#show", as: "transaction"
    end
  end
end
