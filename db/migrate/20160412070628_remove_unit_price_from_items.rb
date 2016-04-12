class RemoveUnitPriceFromItems < ActiveRecord::Migration
  def change
    remove_column :items, :unit_price, :integer
    add_column :items, :unit_price, :decimal
  end
end
