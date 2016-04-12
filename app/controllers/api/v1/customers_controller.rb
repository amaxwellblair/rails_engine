module Api
  module V1
    class CustomersController < ApiController
      def model
        Customer
      end

      def relations
        ["invoices", "transactions"]
      end
    end
  end
end
