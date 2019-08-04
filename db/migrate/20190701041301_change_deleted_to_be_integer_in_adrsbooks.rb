class ChangeDeletedToBeIntegerInAdrsbooks < ActiveRecord::Migration[5.2]
  def change
    change_column :adrsbooks, :deleted, :integer, limit: 1
  end
end
