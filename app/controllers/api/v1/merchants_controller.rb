module Api
  module V1
    class MerchantsController < ApiController
      def model
        Merchant
      end

      def attributes
        [:id, :name, :updated_at, :created_at]
      end
    end
  end
end
