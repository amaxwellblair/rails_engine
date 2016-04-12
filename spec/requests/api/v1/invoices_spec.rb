describe "invoice API" do
  it "should return a list of invoices" do
    customer = Customer.create(first_name: "John", last_name: "Michaels")
    customer2 = Customer.create(first_name: "Butter", last_name: "Poptart")
    merchant = Merchant.create(name: "Bob")
    Invoice.create(customer_id: customer.id, merchant_id: merchant.id, status: "shipped")
    Invoice.create(customer_id: customer2.id, merchant_id: merchant.id, status: "shipped")

    get "/api/v1/invoices.json"
    json = JSON.parse(response.body)

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

    expect(json["customer_id"]).to eq(customer.id)
  end
end
