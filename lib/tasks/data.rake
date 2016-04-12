require "CSV"

namespace :data do
  desc "loads data into the database"
  task load: :environment do
    tables =
    {
      "merchants" => Merchant,
      "customers" => Customer,
      "invoices" => Invoice,
      "items" => Item,
      "invoice_items" => InvoiceItem,
      "transactions" => Transaction
    }
    tables.each do |file, model|
      data = CSV.open("./data/" + file + ".csv", headers: true, header_converters: :symbol)
      data.each do |row|
        puts "Creating more #{file}..."
        params = row.to_hash
        params.delete(:credit_card_expiration_date) if params.has_key?(:credit_card_expiration_date)
        model.create(params)
      end
    end
  end
end
