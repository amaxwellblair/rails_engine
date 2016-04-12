require 'rails_helper'

RSpec.describe Item, type: :model do
  it "converts integers to decimals" do
    item = Item.create(name: "Hello", unit_price: "1000")
    expect(item.unit_price).to eq(10.00)
  end
end
