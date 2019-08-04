class AddDefaultNumberToDevice < ActiveRecord::Migration[5.2]
  def change
    change_column_default :devices, :registered, from: nil, to: true
  end
end
