describe "items API" do
  it "should return a list of items" do
    merchant = Merchant.create(name: "Bob")
    Item.create(name: "pancake", description: "devil's candy", unit_price: 1000, merchant_id: merchant.id)
    Item.create(name: "pop over", description: "yummy", unit_price: 6000, merchant_id: merchant.id)
    Item.create(name: "dirt", description: "Hard as a rock", unit_price: 8989, merchant_id: merchant.id)

    get "/api/v1/items.json"
    json = JSON.parse(response.body)

    expect(json.length).to eq(3)
    expect(json.first["name"]).to eq("pancake")
  end

  it "should return a specific item" do
    merchant = Merchant.create(name: "Bob")
    item = Item.create(name: "pancake", description: "devil's candy", unit_price: 1000, merchant_id: merchant.id)
    Item.create(name: "pop over", description: "yummy", unit_price: 6000, merchant_id: merchant.id)
    Item.create(name: "dirt", description: "Hard as a rock", unit_price: 8989, merchant_id: merchant.id)

    get "/api/v1/items/#{item.id}.json"
    json = JSON.parse(response.body)

    expect(json["name"]).to eq(item.name)
  end
end
