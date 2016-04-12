module Api
  module V1
    class MerchantsController < ApiController
      def model
        Merchant
      end

      def relations
        ["items", "invoices"]
      end
    end
  end
end
