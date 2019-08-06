class CreateSuppliers < ActiveRecord::Migration[5.2]
  def change
    create_table :suppliers do |t|
      t.string :supplier_number
      t.string :name
      t.string :furigana

      t.timestamps
    end
  end
end
