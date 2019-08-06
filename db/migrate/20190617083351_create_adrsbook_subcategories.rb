class CreateAdrsbookSubcategories < ActiveRecord::Migration[5.2]
  def change
    create_table :adrsbook_subcategories do |t|
      t.string :name
      t.integer :order

      t.timestamps
    end
  end
end
