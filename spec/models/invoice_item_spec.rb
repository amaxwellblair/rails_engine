require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  it "converts integers to decimals" do
    invoice_item = InvoiceItem.create(unit_price: 1000)
    expect(invoice_item.unit_price).to eq(10.00)
  end
end
