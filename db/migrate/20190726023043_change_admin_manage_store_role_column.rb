class ChangeAdminManageStoreRoleColumn < ActiveRecord::Migration[5.2]
  def change
    rename_column :admin_manage_stores, :role, :action
  end
end
