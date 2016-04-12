describe "transaction API" do
  it "should return a list of transactions" do
    customer = Customer.create(first_name: "John", last_name: "Michaels")
    customer2 = Customer.create(first_name: "Butter", last_name: "Poptart")
    merchant = Merchant.create(name: "Bob")
    invoice1 = Invoice.create(customer_id: customer.id, merchant_id: merchant.id, status: "shipped")
    invoice2 = Invoice.create(customer_id: customer2.id, merchant_id: merchant.id, status: "shipped")
    Transaction.create(invoice_id: invoice1.id, credit_card_number: 4654405418249632, result: "success" )
    Transaction.create(invoice_id: invoice2.id, credit_card_number: 4580251236515201, result: "failed" )

    get "/api/v1/transactions.json"
    json = JSON.parse(response.body)

    expect(json.length).to eq(2)
    expect(json.first["result"]).to eq("success")
  end

  it "should return a specific transaction" do
    customer = Customer.create(first_name: "John", last_name: "Michaels")
    customer2 = Customer.create(first_name: "Butter", last_name: "Poptart")
    merchant = Merchant.create(name: "Bob")
    invoice1 = Invoice.create(customer_id: customer.id, merchant_id: merchant.id, status: "shipped")
    invoice2 = Invoice.create(customer_id: customer2.id, merchant_id: merchant.id, status: "shipped")
    transaction = Transaction.create(invoice_id: invoice1.id, credit_card_number: 4654405418249632, result: "success" )
    Transaction.create(invoice_id: invoice2.id, credit_card_number: 4580251236515201, result: "failed" )

    get "/api/v1/transactions/#{transaction.id}.json"
    json = JSON.parse(response.body)

    expect(json["result"]).to eq("success")
  end
end
