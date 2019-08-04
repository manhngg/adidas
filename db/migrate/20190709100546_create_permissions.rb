class CreatePermissions < ActiveRecord::Migration[5.2]
  def change
    create_table :permissions do |t|
      t.string :klass
      t.string :action
      t.references :admin, foreign_key: true

      t.timestamps
    end
  end
end