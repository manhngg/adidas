class ProductInventory < ApplicationRecord
  belongs_to :inventory

  has_many :shelf_stock_inventories

  validates :product_name, presence: true
  # validates :jan_code, presence: true, uniqueness: true, numericality: {only_integer: true}, length: {maximum: 13}

  enum unmatched_flag: { less: 0, equal: 1, more: 2 }

  def self.to_csv(header: csv_column_names, row_sep: "\r\n", encoding: Encoding::CP932)
    records = CSV.generate(row_sep: row_sep) do |csv|
      csv << header
      all.each do |record|
        csv << record.csv_column_values
      end
    end
    records.encode(encoding, invalid: :replace, undef: :replace)
  end

  def self.csv_column_names
    ["商品名", "JANコード", "在庫数", "実査数", "照合状態", "実査日"]
  end

  def csv_column_values
    [product_name, jan_code, stock_count, inventory_count, diff_number, inventory_time]
  end
end
