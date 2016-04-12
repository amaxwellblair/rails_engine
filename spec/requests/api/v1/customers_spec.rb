require "rails_helper"

describe "customer API" do
  it "should return a list of customers" do
    Customer.create(first_name: "John", last_name: "Michaels")
    Customer.create(first_name: "Randy", last_name: "Jackson")
    Customer.create(first_name: "Parabold", last_name: "Sanderson")

    get "/api/v1/customers.json"
    json = JSON.parse(response.body)

    expect(json.length).to eq(3)
    expect(json.first["first_name"]).to eq("John")
  end

  it "should return a specific customer" do
    Customer.create(first_name: "John", last_name: "Michaels")
    customer = Customer.create(first_name: "Randy", last_name: "Jackson")
    Customer.create(first_name: "Parabold", last_name: "Sanderson")

    get "/api/v1/customers/#{customer.id}.json"
    json = JSON.parse(response.body)

    expect(json["first_name"]).to eq(customer.first_name)
  end
end
