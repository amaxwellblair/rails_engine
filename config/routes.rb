Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get "/merchants", to: "merchants#index"
    end
  end
end
