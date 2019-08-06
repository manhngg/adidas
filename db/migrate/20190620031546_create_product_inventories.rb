class CreateProductInventories < ActiveRecord::Migration[5.2]
  def change
    create_table :product_inventories do |t|
      t.string :product_name
      t.string :jan_code
      t.integer :stock_count
      t.integer :price
      t.integer :inventory_count
      t.integer :unmatched_flag, limit: 1, default: 0
      t.string :diff_number
      t.datetime :inventory_time
      t.references :inventory, foreign_key: true

      t.timestamps
    end
  end
end
