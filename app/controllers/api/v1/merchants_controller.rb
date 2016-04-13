module Api
  module V1
    class MerchantsController < ApiController
      def model
        Merchant
      end

      def relations
        ["items", "invoices"]
      end

      def most_revenue
        respond_with Merchant.most_revenue(params["quantity"])
      end

      def revenue
        merchant = Merchant.find(params[:id])
        respond_with merchant.revenue(params[:date])
      end

      def most_items
        respond_with Merchant.most_items(params["quantity"])
      end

      def revenue_by_date
        respond_with Merchant.revenue_by_date(params["date"])
      end

      def favorite_customer

      end
    end
  end
end
