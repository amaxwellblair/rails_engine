class RemoveUnitPriceFromInvoiceItems < ActiveRecord::Migration
  def change
    remove_column :invoice_items, :unit_price, :integer
    add_column :invoice_items, :unit_price, :decimal
  end
end
