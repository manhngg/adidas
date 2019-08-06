class CreateApiKeys < ActiveRecord::Migration[5.2]
  def change
    create_table :api_keys do |t|
      t.string :key_name
      t.string :key_value
      t.references :store, foreign_key: true

      t.timestamps
    end
  end
end
