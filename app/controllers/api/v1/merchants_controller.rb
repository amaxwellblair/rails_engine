module Api
  module V1
    class MerchantsController < ApiController
      def index
        respond_with Merchant.all
      end
    end
  end
end
