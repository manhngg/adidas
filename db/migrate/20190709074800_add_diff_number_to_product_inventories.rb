class AddDiffNumberToProductInventories < ActiveRecord::Migration[5.2]
  def change
    add_column :product_inventories, :diff_number, :string
  end
end
