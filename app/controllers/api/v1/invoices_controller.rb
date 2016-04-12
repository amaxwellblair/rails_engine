module Api
  module V1
    class InvoicesController < ApiController
      def model
        Invoice
      end

      def relations
        ["transactions", "invoice_items", "items", "customer", "merchant"]
      end
    end
  end
end
