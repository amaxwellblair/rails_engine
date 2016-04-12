module Api
  module V1
    class InvoiceItemsController < ApiController
      def model
        InvoiceItem
      end

      def relations
        ["invoice", "item"]
      end
    end
  end
end
