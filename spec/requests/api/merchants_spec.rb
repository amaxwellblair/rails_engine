require 'rails_helper'

describe "Merchant API" do
  it 'sends a list of merchants' do

    get '/api/v1/merchants.json'

    json = JSON.parse(response.body)

    expect(response).to be_success

    expect(json['merchants'].length).to eq(10)
  end
end
