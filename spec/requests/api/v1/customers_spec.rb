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
end
