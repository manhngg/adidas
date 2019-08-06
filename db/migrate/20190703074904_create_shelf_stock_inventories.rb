class CreateShelfStockInventories < ActiveRecord::Migration[5.2]
  def change
    create_table :shelf_stock_inventories do |t|
      t.string :shelf_name
      t.integer :row
      t.integer :col
      t.integer :inventory_count
      t.datetime :inventory_time
      t.string :staff_name
      t.string :device_number
      t.integer :error_type, default: 0
      t.references :inventory, foreign_key: true
      t.references :product_inventory, foreign_key: true

      t.timestamps
    end
  end
end
