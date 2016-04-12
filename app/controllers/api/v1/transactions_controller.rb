module Api
  module V1
    class TransactionsController < ApiController
      def model
        Transaction
      end

      def relations
        ["invoice"]
      end
    end
  end
end
