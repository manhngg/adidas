class CreateInventories < ActiveRecord::Migration[5.2]
  def change
    create_table :inventories do |t|
      t.datetime :start_time
      t.datetime :finish_time
      t.integer :status, default: 0
      t.references :store, foreign_key: true

      t.timestamps
    end
  end
end
