class CreateShelfInventories < ActiveRecord::Migration[5.2]
  def change
    create_table :shelf_inventories do |t|
      t.string :shelf_name
      t.string :staff_name
      t.string :device_number
      t.integer :status, default: 0
      t.datetime :start_time
      t.datetime :finish_time
      t.references :inventory, foreign_key: true

      t.timestamps
    end
  end
end
