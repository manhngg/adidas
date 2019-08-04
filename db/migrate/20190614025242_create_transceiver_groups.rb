class CreateTransceiverGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :transceiver_groups do |t|
      t.string :sip_id
      t.string :name
      t.references :store, foreign_key: true

      t.timestamps
    end
  end
end
