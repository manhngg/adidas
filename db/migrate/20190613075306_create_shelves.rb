class CreateShelves < ActiveRecord::Migration[5.2]
  def change
    create_table :shelves do |t|
      t.string :name
      t.integer :row_count
      t.integer :col_count
      t.references :store, foreign_key: true

      t.timestamps
    end
  end
end
