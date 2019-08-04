class CreateInspectionErrors < ActiveRecord::Migration[5.2]
  def change
    create_table :inspection_errors do |t|
      t.datetime :inspection_date
      t.integer :inspection_count
      t.string :jan_code
      t.integer :error_type
      t.references :store, foreign_key: true

      t.timestamps
    end
  end
end
