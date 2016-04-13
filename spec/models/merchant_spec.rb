require 'rails_helper'

RSpec.describe Merchant, type: :model do
  it { should have_many(:items) }
  it { should have_many(:invoices) }

  it "should calculate revenue for a merchant" do
    merchant = Merchant.create(name: "Larimer", created_at: "2012-03-27 14:53:14 UTC", updated_at: "2012-03-27 14:53:52 UTC")
    customer = Customer.create(first_name: "John", last_name: "Michaels")
    customer2 = Customer.create(first_name: "Butter", last_name: "Poptart")
    item = Item.create(name: "pancake", description: "devil's candy", unit_price: 1000, merchant_id: merchant.id)
    item2 = Item.create(name: "pop over", description: "yummy", unit_price: 6000, merchant_id: merchant.id)
    invoice1 = Invoice.create(customer_id: customer.id, merchant_id: merchant.id, status: "shipped")
    invoice2 = Invoice.create(customer_id: customer.id, merchant_id: merchant.id, status: "shipped")
    InvoiceItem.create(item_id: item.id, invoice_id: invoice1.id, quantity: 10, unit_price: 1000)
    InvoiceItem.create(item_id: item2.id, invoice_id: invoice1.id, quantity: 5, unit_price: 6700)
    InvoiceItem.create(item_id: item.id, invoice_id: invoice2.id, quantity: 1, unit_price: 500)
    Transaction.create(invoice_id: invoice1.id, credit_card_number: 4654405418249632, result: "success")
    Transaction.create(invoice_id: invoice1.id, credit_card_number: 4654405418549632, result: "failed")
    Transaction.create(invoice_id: invoice2.id, credit_card_number: 4580251236515201, result: "failed")

    expect(merchant.revenue["revenue"]).to eq(67*5 + 10*10)
  end

  it "calculate revenue by rank" do
    merchant = Merchant.create(name: "Larimer", created_at: "2012-03-27 14:53:14 UTC", updated_at: "2012-03-27 14:53:52 UTC")
    merchant2 = Merchant.create(name: "Schroeder-Jerde", created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    merchant3 = Merchant.create(name: "Pancake", created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    Merchant.create(name: "Larimer", created_at: "2012-03-27 14:53:15 UTC", updated_at: "2012-03-27 14:53:10 UTC")
    customer = Customer.create(first_name: "John", last_name: "Michaels")
    customer2 = Customer.create(first_name: "Butter", last_name: "Poptart")
    item = Item.create(name: "pancake", description: "devil's candy", unit_price: 1000, merchant_id: merchant.id)
    item2 = Item.create(name: "pop over", description: "yummy", unit_price: 6000, merchant_id: merchant2.id)
    invoice1 = Invoice.create(customer_id: customer.id, merchant_id: merchant.id, status: "shipped")
    invoice2 = Invoice.create(customer_id: customer.id, merchant_id: merchant2.id, status: "shipped")
    invoice_item = InvoiceItem.create(item_id: item.id, invoice_id: invoice1.id, quantity: 10, unit_price: 1000)
    InvoiceItem.create(item_id: item2.id, invoice_id: invoice1.id, quantity: 5, unit_price: 6700)
    InvoiceItem.create(item_id: item.id, invoice_id: invoice2.id, quantity: 1, unit_price: 500)
    Transaction.create(invoice_id: invoice1.id, credit_card_number: 4654405418249632, result: "success" )
    Transaction.create(invoice_id: invoice2.id, credit_card_number: 4580251236515201, result: "success" )

    merchants = Merchant.most_revenue(2)
    expect(merchants.first.name).to eq("Larimer")
    expect(merchants.last.name).to eq("Schroeder-Jerde")
  end

  it "calculate items sold by rank" do
    merchant = Merchant.create(name: "Larimer", created_at: "2012-03-27 14:53:14 UTC", updated_at: "2012-03-27 14:53:52 UTC")
    merchant2 = Merchant.create(name: "Schroeder-Jerde", created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    merchant3 = Merchant.create(name: "Pancake", created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    Merchant.create(name: "Larimer", created_at: "2012-03-27 14:53:15 UTC", updated_at: "2012-03-27 14:53:10 UTC")
    customer = Customer.create(first_name: "John", last_name: "Michaels")
    customer2 = Customer.create(first_name: "Butter", last_name: "Poptart")
    item = Item.create(name: "pancake", description: "devil's candy", unit_price: 1000, merchant_id: merchant.id)
    item2 = Item.create(name: "pop over", description: "yummy", unit_price: 6000, merchant_id: merchant2.id)
    invoice1 = Invoice.create(customer_id: customer.id, merchant_id: merchant.id, status: "shipped")
    invoice2 = Invoice.create(customer_id: customer.id, merchant_id: merchant2.id, status: "shipped")
    invoice_item = InvoiceItem.create(item_id: item.id, invoice_id: invoice1.id, quantity: 10, unit_price: 1000)
    InvoiceItem.create(item_id: item2.id, invoice_id: invoice1.id, quantity: 1, unit_price: 6700)
    InvoiceItem.create(item_id: item.id, invoice_id: invoice2.id, quantity: 1, unit_price: 500)
    Transaction.create(invoice_id: invoice1.id, credit_card_number: 4654405418249632, result: "success" )
    Transaction.create(invoice_id: invoice2.id, credit_card_number: 4580251236515201, result: "success" )

    merchants = Merchant.most_items(2)
    expect(merchants.first.name).to eq("Larimer")
    expect(merchants.last.name).to eq("Schroeder-Jerde")
  end
end
