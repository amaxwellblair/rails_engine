describe "invoice_item API" do
  it "should return a list of invoice_items" do
    customer = Customer.create(first_name: "John", last_name: "Michaels")
    merchant = Merchant.create(name: "Bob")
    item = Item.create(name: "pancake", description: "devil's candy", unit_price: 1000, merchant_id: merchant.id)
    item2 = Item.create(name: "pop over", description: "yummy", unit_price: 6000, merchant_id: merchant.id)
    invoice = Invoice.create(customer_id: customer.id, merchant_id: merchant.id, status: "shipped")
    InvoiceItem.create(item_id: item.id, invoice_id: invoice.id, quantity: 10, unit_price: 1000)
    InvoiceItem.create(item_id: item2.id, invoice_id: invoice.id, quantity: 5, unit_price: 6700)
    InvoiceItem.create(item_id: item.id, invoice_id: invoice.id, quantity: 1, unit_price: 500)

    get "/api/v1/invoice_items.json"
    json = JSON.parse(response.body)

    expect(response).to be_success

    expect(json.length).to eq(3)
    expect(json.first["quantity"]).to eq(10)
  end

  it "should return a specific invoice_item" do
    customer = Customer.create(first_name: "John", last_name: "Michaels")
    merchant = Merchant.create(name: "Bob")
    item = Item.create(name: "pancake", description: "devil's candy", unit_price: 1000, merchant_id: merchant.id)
    item2 = Item.create(name: "pop over", description: "yummy", unit_price: 6000, merchant_id: merchant.id)
    invoice = Invoice.create(customer_id: customer.id, merchant_id: merchant.id, status: "shipped")
    invoice_item = InvoiceItem.create(item_id: item.id, invoice_id: invoice.id, quantity: 10, unit_price: 1000)
    InvoiceItem.create(item_id: item2.id, invoice_id: invoice.id, quantity: 5, unit_price: 6700)
    InvoiceItem.create(item_id: item.id, invoice_id: invoice.id, quantity: 1, unit_price: 500)

    get "/api/v1/invoice_items/#{invoice_item.id}.json"
    json = JSON.parse(response.body)

    expect(response).to be_success

    expect(json["quantity"]).to eq(invoice_item.quantity)
  end

  it "find a specific invoice_item" do
    customer = Customer.create(first_name: "John", last_name: "Michaels")
    merchant = Merchant.create(name: "Bob")
    item = Item.create(name: "pancake", description: "devil's candy", unit_price: 1000, merchant_id: merchant.id)
    item2 = Item.create(name: "pop over", description: "yummy", unit_price: 6000, merchant_id: merchant.id)
    invoice = Invoice.create(customer_id: customer.id, merchant_id: merchant.id, status: "shipped")
    invoice_item = InvoiceItem.create(item_id: item.id, invoice_id: invoice.id, quantity: 10, unit_price: 1000)
    InvoiceItem.create(item_id: item2.id, invoice_id: invoice.id, quantity: 5, unit_price: 6700)
    InvoiceItem.create(item_id: item.id, invoice_id: invoice.id, quantity: 1, unit_price: 500)

    get "/api/v1/invoice_items/find.json?quantity=10"
    json = JSON.parse(response.body)

    expect(response).to be_success

    expect(json["quantity"]).to eq(invoice_item.quantity)
  end

  it "find a specific invoice_items by unit price" do
    customer = Customer.create(first_name: "John", last_name: "Michaels")
    merchant = Merchant.create(name: "Bob")
    item = Item.create(name: "pancake", description: "devil's candy", unit_price: 1000, merchant_id: merchant.id)
    item2 = Item.create(name: "pop over", description: "yummy", unit_price: 6000, merchant_id: merchant.id)
    invoice = Invoice.create(customer_id: customer.id, merchant_id: merchant.id, status: "shipped")
    invoice_item = InvoiceItem.create(item_id: item.id, invoice_id: invoice.id, quantity: 10, unit_price: 1000)
    InvoiceItem.create(item_id: item2.id, invoice_id: invoice.id, quantity: 5, unit_price: 6700)
    InvoiceItem.create(item_id: item.id, invoice_id: invoice.id, quantity: 1, unit_price: 1000)

    get "/api/v1/invoice_items/find_all.json?unit_price=10.00"
    json = JSON.parse(response.body)

    expect(response).to be_success

    expect(json.first["quantity"]).to eq(invoice_item.quantity)
  end

  it "return a random invoice_item" do
    customer = Customer.create(first_name: "John", last_name: "Michaels")
    merchant = Merchant.create(name: "Bob")
    item = Item.create(name: "pancake", description: "devil's candy", unit_price: 1000, merchant_id: merchant.id)
    item2 = Item.create(name: "pop over", description: "yummy", unit_price: 6000, merchant_id: merchant.id)
    invoice = Invoice.create(customer_id: customer.id, merchant_id: merchant.id, status: "shipped")
    invoice_item = InvoiceItem.create(item_id: item.id, invoice_id: invoice.id, quantity: 10, unit_price: 1000)
    InvoiceItem.create(item_id: item2.id, invoice_id: invoice.id, quantity: 5, unit_price: 6700)
    InvoiceItem.create(item_id: item.id, invoice_id: invoice.id, quantity: 1, unit_price: 1000)

    get "/api/v1/invoice_items/random.json"
    json = JSON.parse(response.body)

    expect(response).to be_success
  end

  it "return an invoice" do
    customer = Customer.create(first_name: "John", last_name: "Michaels")
    merchant = Merchant.create(name: "Bob")
    item = Item.create(name: "pancake", description: "devil's candy", unit_price: 1000, merchant_id: merchant.id)
    item2 = Item.create(name: "pop over", description: "yummy", unit_price: 6000, merchant_id: merchant.id)
    invoice = Invoice.create(customer_id: customer.id, merchant_id: merchant.id, status: "shipped")
    invoice_item = InvoiceItem.create(item_id: item.id, invoice_id: invoice.id, quantity: 10, unit_price: 1000)
    invoice_item = InvoiceItem.create(item_id: item2.id, invoice_id: invoice.id, quantity: 5, unit_price: 6700)
    InvoiceItem.create(item_id: item.id, invoice_id: invoice.id, quantity: 1, unit_price: 1000)

    get "/api/v1/invoice_items/#{invoice_item.id}/invoice.json"
    json = JSON.parse(response.body)

    expect(response).to be_success

    expect(json["customer_id"]).to eq(customer.id)
  end

  it "return an item" do
    customer = Customer.create(first_name: "John", last_name: "Michaels")
    merchant = Merchant.create(name: "Bob")
    item = Item.create(name: "pancake", description: "devil's candy", unit_price: 1000, merchant_id: merchant.id)
    item2 = Item.create(name: "pop over", description: "yummy", unit_price: 6000, merchant_id: merchant.id)
    invoice = Invoice.create(customer_id: customer.id, merchant_id: merchant.id, status: "shipped")
    invoice_item = InvoiceItem.create(item_id: item.id, invoice_id: invoice.id, quantity: 10, unit_price: 1000)
    invoice_item = InvoiceItem.create(item_id: item2.id, invoice_id: invoice.id, quantity: 5, unit_price: 6700)
    InvoiceItem.create(item_id: item.id, invoice_id: invoice.id, quantity: 1, unit_price: 1000)

    get "/api/v1/invoice_items/#{invoice_item.id}/item.json"
    json = JSON.parse(response.body)

    expect(response).to be_success

    expect(json["name"]).to eq("pop over")
  end
end
