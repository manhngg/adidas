class ChangeNumberDeviceFromIntegerToString < ActiveRecord::Migration[5.2]
  def change
    change_column :devices, :number, :string
  end
end
