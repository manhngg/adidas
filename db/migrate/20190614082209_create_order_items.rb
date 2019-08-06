class CreateOrderItems < ActiveRecord::Migration[5.2]
  def change
    create_table :order_items do |t|
      t.integer :order_count
      t.datetime :delivery_date
      t.references :product, foreign_key: true
      t.references :order, foreign_key: true
      t.references :supplier, foreign_key: true

      t.timestamps
    end
  end
end
