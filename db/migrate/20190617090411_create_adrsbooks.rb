class CreateAdrsbooks < ActiveRecord::Migration[5.2]
  def change
    create_table :adrsbooks do |t|
      t.string :name
      t.string :furigana
      t.string :category
      t.string :tel1
      t.string :tel2
      t.string :tel3
      t.text :note
      t.boolean :registered
      t.boolean :deleted
      t.references :store, foreign_key: true
      t.references :adrsbook_subcategory, foreign_key: true

      t.timestamps
    end
  end
end
