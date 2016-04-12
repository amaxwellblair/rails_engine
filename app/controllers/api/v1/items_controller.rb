module Api
  module V1
    class ItemsController < ApiController
      def model
        Item
      end

      def relations
        ["invoice_items", "merchant"]
      end
    end
  end
end
