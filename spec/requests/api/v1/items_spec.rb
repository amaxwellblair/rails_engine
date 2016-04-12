describe "items API" do
  it "should return a list of items" do
    merchant = Merchant.create(name: "Bob")
    Item.create(name: "pancake", description: "devil's candy", unit_price: 1000, merchant_id: merchant.id)
    Item.create(name: "pop over", description: "yummy", unit_price: 6000, merchant_id: merchant.id)
    Item.create(name: "dirt", description: "Hard as a rock", unit_price: 8989, merchant_id: merchant.id)

    get "/api/v1/items.json"
    json = JSON.parse(response.body)

    expect(response).to be_success

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

    expect(response).to be_success

    expect(json["name"]).to eq(item.name)
  end

  it "finds a specific item" do
    merchant = Merchant.create(name: "Bob")
    Item.create(name: "pancake", description: "devil's candy", unit_price: 1000, merchant_id: merchant.id)
    Item.create(name: "pop over", description: "yummy", unit_price: 6000, merchant_id: merchant.id)
    Item.create(name: "dirt", description: "Hard as a rock", unit_price: 8989, merchant_id: merchant.id)

    get "/api/v1/items/find.json?unit_price=89.89"
    json = JSON.parse(response.body)

    expect(response).to be_success

    expect(json["name"]).to eq("dirt")
  end

  it "finds a specific item sad path" do
    merchant = Merchant.create(name: "Bob")
    Item.create(name: "pancake", description: "devil's candy", unit_price: 1000, merchant_id: merchant.id)
    Item.create(name: "pop over", description: "yummy", unit_price: 6000, merchant_id: merchant.id)
    Item.create(name: "dirt", description: "Hard as a rock", unit_price: 8989, merchant_id: merchant.id)

    get "/api/v1/items/find.json?pokemon=pancake"
    json = JSON.parse(response.body)

    expect(response.status).to eq(404)

    expect(json["error"]).to eq("column does not exist")
  end

  it "finds all of a item by name" do
    merchant = Merchant.create(name: "Bob")
    Item.create(name: "pancake", description: "devil's candy", unit_price: 1000, merchant_id: merchant.id)
    Item.create(name: "pop over", description: "yummy", unit_price: 6000, merchant_id: merchant.id)
    Item.create(name: "pancake", description: "Hard as a rock", unit_price: 8989, merchant_id: merchant.id)

    get "/api/v1/items/find_all.json?name=pancake"
    json = JSON.parse(response.body)

    expect(response).to be_success

    expect(json.length).to eq(2)
    expect(json.last["name"]).to eq("pancake")
  end

  it "return random item" do
    merchant = Merchant.create(name: "Bob")
    Item.create(name: "pancake", description: "devil's candy", unit_price: 1000, merchant_id: merchant.id)
    Item.create(name: "pop over", description: "yummy", unit_price: 6000, merchant_id: merchant.id)
    Item.create(name: "pancake", description: "Hard as a rock", unit_price: 8989, merchant_id: merchant.id)

    get "/api/v1/items/random.json"
    json = JSON.parse(response.body)

    expect(response).to be_success
  end
end
