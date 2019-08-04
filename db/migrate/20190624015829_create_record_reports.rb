class CreateRecordReports < ActiveRecord::Migration[5.2]
  def change
    create_table :record_reports do |t|
      t.datetime :record_date
      t.datetime :start_time
      t.datetime :stop_time
      t.integer :break_time
      t.references :user, foreign_key: true
      t.references :store, foreign_key: true

      t.timestamps
    end
  end
end
