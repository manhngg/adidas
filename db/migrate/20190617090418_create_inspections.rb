class CreateInspections < ActiveRecord::Migration[5.2]
  def change
    create_table :inspections do |t|
      t.integer :inspection_count
      t.string :staff_name
      t.string :device_number
      t.datetime :last_inspection
      t.references :order_item, foreign_key: true
      t.references :order, foreign_key: true

      t.timestamps
    end
  end
end
