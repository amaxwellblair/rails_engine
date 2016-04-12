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
end
