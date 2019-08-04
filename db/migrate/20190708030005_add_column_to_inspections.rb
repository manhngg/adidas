class AddColumnToInspections < ActiveRecord::Migration[5.2]
  def change
    add_column :inspections, :last_inspection, :datetime
    add_reference :inspections, :order, index: true
    add_foreign_key :inspections, :orders
  end
end
