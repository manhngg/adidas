class RemovePwdDigest < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :password_digest
    remove_column :admins, :password_digest 
  end
end
