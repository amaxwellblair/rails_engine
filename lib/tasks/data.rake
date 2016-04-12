require "CSV"

namespace :data do
  desc "loads data into the database"
  task load: :environment do
    tables = { "merchants" => Merchant }
    tables.each do |data, model|
      data = CSV.open("./data/" + data + ".csv", headers: true, header_converters: :symbol)
      data.each do |row|
        model.create(row.to_hash)
      end
    end
  end
end
