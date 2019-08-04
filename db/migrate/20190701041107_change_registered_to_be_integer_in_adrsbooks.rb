class ChangeRegisteredToBeIntegerInAdrsbooks < ActiveRecord::Migration[5.2]
  def change
    change_column :adrsbooks, :registered, :integer, limit: 1
  end
end
