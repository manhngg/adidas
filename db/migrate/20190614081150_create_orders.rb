class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.datetime :order_date
      t.datetime :last_inspection
      t.string :order_number
      t.integer :order_count
      t.integer :inspection_count
      t.integer :inspected, default: 0, limit: 1
      t.references :supplier, foreign_key: true
      t.references :store, foreign_key: true

      t.timestamps
    end
  end
end
