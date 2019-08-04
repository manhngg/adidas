class AddSupplierIdToOrderItems < ActiveRecord::Migration[5.2]
  def change
    add_reference :order_items, :supplier, index: true
    add_foreign_key :order_items, :suppliers
  end
end
