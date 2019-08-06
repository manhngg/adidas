class CreateStocks < ActiveRecord::Migration[5.2]
  def change
    create_table :stocks do |t|
      t.integer :stock_count
      t.integer :price
      t.references :store, foreign_key: true
      t.references :product, foreign_key: true

      t.timestamps
    end
  end
end
