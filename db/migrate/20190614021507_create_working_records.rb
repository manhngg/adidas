class CreateWorkingRecords < ActiveRecord::Migration[5.2]
  def change
    create_table :working_records do |t|
      t.datetime :action_time
      t.references :user, foreign_key: true
      t.references :record_action, foreign_key: true

      t.timestamps
    end
  end
end
