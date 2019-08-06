class CreateStores < ActiveRecord::Migration[5.2]
  def change
    create_table :stores do |t|
      t.string :name
      t.references :region, foreign_key: true
      t.references :prefecture, foreign_key: true
      t.references :area, foreign_key: true

      t.timestamps
    end
  end
end
