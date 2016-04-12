require "rails_helper"

describe "Merchant API" do
  it "sends a list of merchants" do
    Merchant.create(name: "Bob")
    Merchant.create(name: "Todd")
    Merchant.create(name: "Billy")

    get "/api/v1/merchants.json"

    json = JSON.parse(response.body)

    expect(response).to be_success

    expect(json.length).to eq(3)
    expect(json.first["name"]).to eq("Bob")
  end

  it "sends a specific merchant" do
    Merchant.create(name: "Bob")
    merchant = Merchant.create(name: "Todd")
    Merchant.create(name: "Billy")

    get "/api/v1/merchants/#{merchant.id}.json"

    json = JSON.parse(response.body)

    expect(response).to be_success

    expect(json["name"]).to eq(merchant.name)
  end

  it "finds a specific merchant by name" do
    Merchant.create(name: "Jackson", created_at: "2012-03-27 14:53:14 UTC", updated_at: "2012-03-27 14:53:52 UTC")
    merchant = Merchant.create(name: "Schroeder-Jerde", created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    Merchant.create(name: "Larimer", created_at: "2012-03-27 14:53:15 UTC", updated_at: "2012-03-27 14:53:10 UTC")

    get "/api/v1/merchants/find.json?name=#{merchant.name}"

    json = JSON.parse(response.body)

    expect(response).to be_success

    expect(json["name"]).to eq(merchant.name)
  end

  it "finds a specific merchant sad path" do
    Merchant.create(name: "Jackson", created_at: "2012-03-27 14:53:14 UTC", updated_at: "2012-03-27 14:53:52 UTC")
    merchant = Merchant.create(name: "Schroeder-Jerde", created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    Merchant.create(name: "Larimer", created_at: "2012-03-27 14:53:15 UTC", updated_at: "2012-03-27 14:53:10 UTC")

    get "/api/v1/merchants/find.json?pokemon=#{merchant.name}"

    json = JSON.parse(response.body)

    expect(response.status).to eq(404)

    expect(json["error"]).to eq("column does not exist")
  end

  it "finds multiple merchants by name" do
    merchant = Merchant.create(name: "Larimer", created_at: "2012-03-27 14:53:14 UTC", updated_at: "2012-03-27 14:53:52 UTC")
    Merchant.create(name: "Schroeder-Jerde", created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    Merchant.create(name: "Larimer", created_at: "2012-03-27 14:53:15 UTC", updated_at: "2012-03-27 14:53:10 UTC")

    get "/api/v1/merchants/find_all.json?name=#{merchant.name}"

    json = JSON.parse(response.body)

    expect(response).to be_success

    expect(json.length).to eq(2)
    expect(json.first["name"]).to eq(merchant.name)
  end

  it "finds multiple merchants sad path" do
    merchant = Merchant.create(name: "Larimer", created_at: "2012-03-27 14:53:14 UTC", updated_at: "2012-03-27 14:53:52 UTC")
    Merchant.create(name: "Schroeder-Jerde", created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    Merchant.create(name: "Larimer", created_at: "2012-03-27 14:53:15 UTC", updated_at: "2012-03-27 14:53:10 UTC")

    get "/api/v1/merchants/find_all.json?pokemon=#{merchant.name}"

    json = JSON.parse(response.body)

    expect(response.status).to eq(404)

    expect(json["error"]).to eq("column does not exist")
  end

  it "Returns a random merchant" do
    merchant = Merchant.create(name: "Larimer", created_at: "2012-03-27 14:53:14 UTC", updated_at: "2012-03-27 14:53:52 UTC")
    Merchant.create(name: "Schroeder-Jerde", created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    Merchant.create(name: "Larimer", created_at: "2012-03-27 14:53:15 UTC", updated_at: "2012-03-27 14:53:10 UTC")

    get "/api/v1/merchants/random.json?"

    json = JSON.parse(response.body)

    expect(response).to be_success
  end

  it "Returns a related items" do
    merchant = Merchant.create(name: "Larimer", created_at: "2012-03-27 14:53:14 UTC", updated_at: "2012-03-27 14:53:52 UTC")
    Merchant.create(name: "Schroeder-Jerde", created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    Merchant.create(name: "Larimer", created_at: "2012-03-27 14:53:15 UTC", updated_at: "2012-03-27 14:53:10 UTC")
    Item.create(name: "pop over", description: "yummy", unit_price: 6000, merchant_id: merchant.id)
    Item.create(name: "dirt", description: "Hard as a rock", unit_price: 8989, merchant_id: merchant.id)

    get "/api/v1/merchants/#{merchant.id}/items.json?"

    json = JSON.parse(response.body)

    expect(json.length).to eq(2)
    expect(json.first["name"]).to eq("pop over")
  end

  it "Returns a related invoices" do
    merchant = Merchant.create(name: "Larimer", created_at: "2012-03-27 14:53:14 UTC", updated_at: "2012-03-27 14:53:52 UTC")
    Merchant.create(name: "Schroeder-Jerde", created_at: "2012-03-27 14:53:59 UTC", updated_at: "2012-03-27 14:53:59 UTC")
    Merchant.create(name: "Larimer", created_at: "2012-03-27 14:53:15 UTC", updated_at: "2012-03-27 14:53:10 UTC")
    customer = Customer.create(first_name: "John", last_name: "Michaels")
    customer2 = Customer.create(first_name: "Butter", last_name: "Poptart")
    Invoice.create(customer_id: customer.id, merchant_id: merchant.id, status: "shipped")
    invoice = Invoice.create(customer_id: customer2.id, merchant_id: merchant.id, status: "shipped")


    get "/api/v1/merchants/#{merchant.id}/invoices.json?"

    json = JSON.parse(response.body)

    expect(json.length).to eq(2)
    expect(json.last["customer_id"]).to eq(invoice.customer_id)
  end
end
