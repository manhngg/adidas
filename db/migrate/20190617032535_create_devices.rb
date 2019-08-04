class CreateDevices < ActiveRecord::Migration[5.2]
  def change
    create_table :devices do |t|
      t.string :number
      t.string :name
      t.string :encrypted_password
      t.boolean :registered, default: false
      t.references :store, foreign_key: true
      t.references :transceiver_group, foreign_key: true

      t.timestamps
    end
  end
end
