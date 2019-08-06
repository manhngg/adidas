class CreateLoginLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :login_logs do |t|
      t.string :staff_id
      t.string :full_name
      t.string :ip_address
      t.integer :action_type
      t.datetime :action_time

      t.timestamps
    end
  end
end
