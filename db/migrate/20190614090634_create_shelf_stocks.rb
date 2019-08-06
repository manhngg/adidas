class CreateShelfStocks < ActiveRecord::Migration[5.2]
  def change
    create_table :shelf_stocks do |t|
      t.integer :row
      t.integer :column
      t.references :shelf, foreign_key: true
      t.references :stock, foreign_key: true

      t.timestamps
    end
  end
end
