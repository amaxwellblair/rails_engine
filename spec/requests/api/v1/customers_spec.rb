require "rails_helper"

describe "customer API" do
  it "should return a list of customers" do
    Customer.create(first_name: "John", last_name: "Michaels")
    Customer.create(first_name: "Randy", last_name: "Jackson")
    Customer.create(first_name: "Parabold", last_name: "Sanderson")

    get "/api/v1/customers.json"
    json = JSON.parse(response.body)

    expect(response).to be_success

    expect(json.length).to eq(3)
    expect(json.first["first_name"]).to eq("John")
  end

  it "should return a specific customer" do
    Customer.create(first_name: "John", last_name: "Michaels")
    customer = Customer.create(first_name: "Randy", last_name: "Jackson")
    Customer.create(first_name: "Parabold", last_name: "Sanderson")

    get "/api/v1/customers/#{customer.id}.json"
    json = JSON.parse(response.body)

    expect(response).to be_success

    expect(json["first_name"]).to eq(customer.first_name)
  end

  it "find a specific customer by first name" do
    Customer.create(first_name: "John", last_name: "Michaels")
    Customer.create(first_name: "Poppy", last_name: "Jackson")
    Customer.create(first_name: "Parabold", last_name: "Sanderson")

    get "/api/v1/customers/find.json?first_name=john"
    json = JSON.parse(response.body)

    expect(response).to be_success

    expect(json["first_name"]).to eq("John")
  end

  it "find multiple customers by date" do
    Customer.create(first_name: "John", last_name: "Michaels", created_at: "2012-03-27 14:53:14 UTC", updated_at: "2012-03-27 14:53:52 UTC")
    Customer.create(first_name: "John", last_name: "Jackson", created_at: "2012-03-27 14:53:14 UTC", updated_at: "2012-03-27 14:53:52 UTC")
    Customer.create(first_name: "Parabold", last_name: "Sanderson", created_at: "2012-03-27 14:53:14 UTC", updated_at: "2012-03-27 14:53:52 UTC")

    get "/api/v1/customers/find_all.json?created_at=2012-03-27 14:53:14 UTC"
    json = JSON.parse(response.body)

    expect(response).to be_success

    expect(json.length).to eq(3)
    expect(json.first["first_name"]).to eq("John")
  end

  it "find a random customer" do
    Customer.create(first_name: "John", last_name: "Michaels", created_at: "2012-03-27 14:53:14 UTC", updated_at: "2012-03-27 14:53:52 UTC")
    Customer.create(first_name: "John", last_name: "Jackson", created_at: "2012-03-27 14:53:14 UTC", updated_at: "2012-03-27 14:53:52 UTC")
    Customer.create(first_name: "Parabold", last_name: "Sanderson", created_at: "2012-03-27 14:53:14 UTC", updated_at: "2012-03-27 14:53:52 UTC")

    get "/api/v1/customers/random.json"
    json = JSON.parse(response.body)

    expect(response).to be_success
  end

  it "returns invoices" do
    customer = Customer.create(first_name: "John", last_name: "Michaels", created_at: "2012-03-27 14:53:14 UTC", updated_at: "2012-03-27 14:53:52 UTC")
    customer2 = Customer.create(first_name: "John", last_name: "Jackson", created_at: "2012-03-27 14:53:14 UTC", updated_at: "2012-03-27 14:53:52 UTC")
    Customer.create(first_name: "Parabold", last_name: "Sanderson", created_at: "2012-03-27 14:53:14 UTC", updated_at: "2012-03-27 14:53:52 UTC")
    merchant = Merchant.create(name: "Bob")
    invoice = Invoice.create(customer_id: customer.id, merchant_id: merchant.id, status: "shipped")
    Invoice.create(customer_id: customer2.id, merchant_id: merchant.id, status: "shipped")

    get "/api/v1/customers/#{customer.id}/invoices.json"
    json = JSON.parse(response.body)

    expect(response).to be_success

    expect(json.length).to eq(1)
    expect(json.first["customer_id"]).to eq(customer.id)
  end

  it "returns transactions" do
    customer = Customer.create(first_name: "John", last_name: "Michaels", created_at: "2012-03-27 14:53:14 UTC", updated_at: "2012-03-27 14:53:52 UTC")
    customer2 = Customer.create(first_name: "John", last_name: "Jackson", created_at: "2012-03-27 14:53:14 UTC", updated_at: "2012-03-27 14:53:52 UTC")
    Customer.create(first_name: "Parabold", last_name: "Sanderson", created_at: "2012-03-27 14:53:14 UTC", updated_at: "2012-03-27 14:53:52 UTC")
    merchant = Merchant.create(name: "Bob")
    invoice = Invoice.create(customer_id: customer.id, merchant_id: merchant.id, status: "shipped")
    Invoice.create(customer_id: customer2.id, merchant_id: merchant.id, status: "shipped")
    Transaction.create(invoice_id: invoice.id, credit_card_number: 4654405418249632, result: "success" )
    Transaction.create(invoice_id: invoice.id, credit_card_number: 4580251236515201, result: "failed" )

    get "/api/v1/customers/#{customer.id}/transactions.json"
    json = JSON.parse(response.body)

    expect(response).to be_success

    expect(json.length).to eq(2)
    expect(json.first["result"]).to eq("success")
  end

  it "relation sad path" do
    customer = Customer.create(first_name: "John", last_name: "Michaels", created_at: "2012-03-27 14:53:14 UTC", updated_at: "2012-03-27 14:53:52 UTC")
    customer2 = Customer.create(first_name: "John", last_name: "Jackson", created_at: "2012-03-27 14:53:14 UTC", updated_at: "2012-03-27 14:53:52 UTC")
    Customer.create(first_name: "Parabold", last_name: "Sanderson", created_at: "2012-03-27 14:53:14 UTC", updated_at: "2012-03-27 14:53:52 UTC")
    merchant = Merchant.create(name: "Bob")
    invoice = Invoice.create(customer_id: customer.id, merchant_id: merchant.id, status: "shipped")
    Invoice.create(customer_id: customer2.id, merchant_id: merchant.id, status: "shipped")
    Transaction.create(invoice_id: invoice.id, credit_card_number: 4654405418249632, result: "success" )
    Transaction.create(invoice_id: invoice.id, credit_card_number: 4580251236515201, result: "failed" )

    get "/api/v1/customers/#{customer.id}/pancakes.json"
    json = JSON.parse(response.body)

    expect(response.status).to eq(404)

    expect(json["error"]).to eq("relation does not exist")
  end
end
