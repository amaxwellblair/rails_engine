class InvoiceItem < ActiveRecord::Base
  belongs_to :item
  belongs_to :invoice
  before_validation :convert_to_decimal

  def convert_to_decimal
    self.unit_price = (unit_price / 100.0).round(2)
  end
end
