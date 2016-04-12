class Item < ActiveRecord::Base
  belongs_to :merchant
  before_validation :convert_to_decimal

  def convert_to_decimal
    self.unit_price = (unit_price / 100.0).round(2)
  end
end
