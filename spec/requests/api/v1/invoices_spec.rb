describe "invoice API" do
  it "should return a list of invoices" do
    customer = Customer.create(first_name: "John", last_name: "Michaels")
    customer2 = Customer.create(first_name: "Butter", last_name: "Poptart")
    merchant = Merchant.create(name: "Bob")
    Invoice.create(customer_id: customer.id, merchant_id: merchant.id, status: "shipped")
    Invoice.create(customer_id: customer2.id, merchant_id: merchant.id, status: "shipped")

    get "/api/v1/invoices.json"
    json = JSON.parse(response.body)

    expect(response).to be_success

    expect(json.length).to eq(2)
    expect(json.first["customer_id"]).to eq(customer.id)
  end

  it "should return a specific invoice" do
    customer = Customer.create(first_name: "John", last_name: "Michaels")
    customer2 = Customer.create(first_name: "Butter", last_name: "Poptart")
    merchant = Merchant.create(name: "Bob")
    invoice = Invoice.create(customer_id: customer.id, merchant_id: merchant.id, status: "shipped")
    Invoice.create(customer_id: customer2.id, merchant_id: merchant.id, status: "shipped")

    get "/api/v1/invoices/#{invoice.id}.json"
    json = JSON.parse(response.body)

    expect(response).to be_success

    expect(json["customer_id"]).to eq(customer.id)
  end

  it "finds a specific invoice" do
    customer = Customer.create(first_name: "John", last_name: "Michaels")
    customer2 = Customer.create(first_name: "Butter", last_name: "Poptart")
    merchant = Merchant.create(name: "Bob")
    invoice = Invoice.create(customer_id: customer.id, merchant_id: merchant.id, status: "shipped")
    Invoice.create(customer_id: customer2.id, merchant_id: merchant.id, status: "shipped")

    get "/api/v1/invoices/find.json?customer_id=#{customer.id}"
    json = JSON.parse(response.body)

    expect(response).to be_success

    expect(json["customer_id"]).to eq(customer.id)
  end

  it "finds specific invoices by merchant id" do
    customer = Customer.create(first_name: "John", last_name: "Michaels")
    customer2 = Customer.create(first_name: "Butter", last_name: "Poptart")
    merchant = Merchant.create(name: "Bob")
    invoice = Invoice.create(customer_id: customer.id, merchant_id: merchant.id, status: "shipped")
    Invoice.create(customer_id: customer2.id, merchant_id: merchant.id, status: "shipped")

    get "/api/v1/invoices/find_all.json?merchant_id=#{merchant.id}"
    json = JSON.parse(response.body)

    expect(response).to be_success

    expect(json.length).to eq(2)
    expect(json.last["merchant_id"]).to eq(merchant.id)
  end

  it "finds a random invoice" do
    customer = Customer.create(first_name: "John", last_name: "Michaels")
    customer2 = Customer.create(first_name: "Butter", last_name: "Poptart")
    merchant = Merchant.create(name: "Bob")
    invoice = Invoice.create(customer_id: customer.id, merchant_id: merchant.id, status: "shipped")
    Invoice.create(customer_id: customer2.id, merchant_id: merchant.id, status: "shipped")

    get "/api/v1/invoices/random.json"
    json = JSON.parse(response.body)

    expect(response).to be_success
  end

  it "returns transactions" do
    customer = Customer.create(first_name: "John", last_name: "Michaels")
    customer2 = Customer.create(first_name: "Butter", last_name: "Poptart")
    merchant = Merchant.create(name: "Bob")
    invoice1 = Invoice.create(customer_id: customer.id, merchant_id: merchant.id, status: "shipped")
    invoice2 = Invoice.create(customer_id: customer2.id, merchant_id: merchant.id, status: "shipped")
    transaction = Transaction.create(invoice_id: invoice1.id, credit_card_number: 4654405418249632, result: "success" )
    Transaction.create(invoice_id: invoice2.id, credit_card_number: 4580251236515201, result: "failed" )
    Transaction.create(invoice_id: invoice2.id, credit_card_number: 458035123615201, result: "success" )

    get "/api/v1/invoices/#{invoice2.id}/transactions.json"
    json = JSON.parse(response.body)

    expect(response).to be_success

    expect(json.length).to eq(2)
    expect(json.first["result"]).to eq("failed")
  end

  it "returns invoice items" do
    customer = Customer.create(first_name: "John", last_name: "Michaels")
    customer2 = Customer.create(first_name: "Butter", last_name: "Poptart")
    merchant = Merchant.create(name: "Bob")
    item = Item.create(name: "pancake", description: "devil's candy", unit_price: 1000, merchant_id: merchant.id)
    item2 = Item.create(name: "pop over", description: "yummy", unit_price: 6000, merchant_id: merchant.id)
    invoice1 = Invoice.create(customer_id: customer.id, merchant_id: merchant.id, status: "shipped")
    invoice2 = Invoice.create(customer_id: customer2.id, merchant_id: merchant.id, status: "shipped")
    InvoiceItem.create(item_id: item.id, invoice_id: invoice1.id, quantity: 10, unit_price: 1000)
    InvoiceItem.create(item_id: item2.id, invoice_id: invoice1.id, quantity: 5, unit_price: 6700)
    InvoiceItem.create(item_id: item.id, invoice_id: invoice2.id, quantity: 1, unit_price: 500)

    get "/api/v1/invoices/#{invoice1.id}/invoice_items.json"
    json = JSON.parse(response.body)

    expect(response).to be_success

    expect(json.length).to eq(2)
    expect(json.first["quantity"]).to eq(10)
  end

  it "returns items" do
    customer = Customer.create(first_name: "John", last_name: "Michaels")
    customer2 = Customer.create(first_name: "Butter", last_name: "Poptart")
    merchant = Merchant.create(name: "Bob")
    item = Item.create(name: "pancake", description: "devil's candy", unit_price: 1000, merchant_id: merchant.id)
    item2 = Item.create(name: "pop over", description: "yummy", unit_price: 6000, merchant_id: merchant.id)
    invoice1 = Invoice.create(customer_id: customer.id, merchant_id: merchant.id, status: "shipped")
    invoice2 = Invoice.create(customer_id: customer2.id, merchant_id: merchant.id, status: "shipped")
    InvoiceItem.create(item_id: item.id, invoice_id: invoice1.id, quantity: 10, unit_price: 1000)
    InvoiceItem.create(item_id: item.id, invoice_id: invoice1.id, quantity: 5, unit_price: 6700)
    InvoiceItem.create(item_id: item2.id, invoice_id: invoice2.id, quantity: 1, unit_price: 500)

    get "/api/v1/invoices/#{invoice1.id}/items.json"
    json = JSON.parse(response.body)

    expect(response).to be_success

    expect(json.length).to eq(2)
    expect(json.first["name"]).to eq("pancake")
  end

  it "returns customer" do
    customer = Customer.create(first_name: "John", last_name: "Michaels")
    customer2 = Customer.create(first_name: "Butter", last_name: "Poptart")
    merchant = Merchant.create(name: "Bob")
    item = Item.create(name: "pancake", description: "devil's candy", unit_price: 1000, merchant_id: merchant.id)
    item2 = Item.create(name: "pop over", description: "yummy", unit_price: 6000, merchant_id: merchant.id)
    invoice1 = Invoice.create(customer_id: customer.id, merchant_id: merchant.id, status: "shipped")
    invoice2 = Invoice.create(customer_id: customer2.id, merchant_id: merchant.id, status: "shipped")

    get "/api/v1/invoices/#{invoice1.id}/customer.json"
    json = JSON.parse(response.body)

    expect(response).to be_success

    expect(json["first_name"]).to eq("John")
  end

  it "returns merchant" do
    customer = Customer.create(first_name: "John", last_name: "Michaels")
    customer2 = Customer.create(first_name: "Butter", last_name: "Poptart")
    merchant = Merchant.create(name: "Bob")
    item = Item.create(name: "pancake", description: "devil's candy", unit_price: 1000, merchant_id: merchant.id)
    item2 = Item.create(name: "pop over", description: "yummy", unit_price: 6000, merchant_id: merchant.id)
    invoice1 = Invoice.create(customer_id: customer.id, merchant_id: merchant.id, status: "shipped")
    invoice2 = Invoice.create(customer_id: customer2.id, merchant_id: merchant.id, status: "shipped")

    get "/api/v1/invoices/#{invoice1.id}/merchant.json"
    json = JSON.parse(response.body)

    expect(response).to be_success

    expect(json["name"]).to eq("Bob")
  end
end
