require 'rails_helper'

describe "Merchant API" do
  it 'sends a list of merchants' do
    Merchant.create(name: "Bob")
    Merchant.create(name: "Todd")
    Merchant.create(name: "Billy")

    get '/api/v1/merchants.json'

    json = JSON.parse(response.body)

    expect(response).to be_success

    expect(json.length).to eq(3)
    expect(json.first['name']).to eq("Bob")
  end

  it 'sends a specific merchant' do
    Merchant.create(name: "Bob")
    Merchant.create(name: "Todd")
    Merchant.create(name: "Billy")

    get '/api/v1/merchants.json'

    json = JSON.parse(response.body)

    expect(response).to be_success

    expect(json.length).to eq(3)
    expect(json.first['name']).to eq("Bob")
  end
end
