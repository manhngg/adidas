class CreateAdminManageStores < ActiveRecord::Migration[5.2]
  def change
    create_table :admin_manage_stores do |t|
      t.references :admin, foreign_key: true
      t.references :store, foreign_key: true
      t.string :role

      t.timestamps
    end
  end
end
