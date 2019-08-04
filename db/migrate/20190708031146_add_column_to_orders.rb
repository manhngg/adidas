class AddColumnToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :order_count, :integer
    add_column :orders, :inspected, :integer, limit: 1, default: 0
    add_column :orders, :inspection_count, :integer
    add_column :orders, :last_inspection, :datetime
  end
end
