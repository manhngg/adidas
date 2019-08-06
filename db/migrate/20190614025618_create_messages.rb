class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.string :submit_user_name
      t.string :msg_text
      t.references :message_group, foreign_key: true

      t.timestamps
    end
  end
end
