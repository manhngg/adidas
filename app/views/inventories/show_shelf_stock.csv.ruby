require 'csv'

CSV.generate(encoding: Encoding::SJIS, row_sep: "\r\n", force_quotes: true) do |csv|
  csv_column_names = %w(棚名 段 列 実査数 実査日時 担当者 端末番号)
  csv << csv_column_names
  @shelf_stock_inventories.each do |shelf_stock_inventory|
    csv_column_values = [
      shelf_stock_inventory.shelf_name,
      shelf_stock_inventory.row,
      shelf_stock_inventory.col,
      shelf_stock_inventory.inventory_count,
      shelf_stock_inventory.inventory_time,
      shelf_stock_inventory.staff_name,
      shelf_stock_inventory.device_number
    ]
    csv << csv_column_values
  end
end