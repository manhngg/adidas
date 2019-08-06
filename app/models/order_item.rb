# == Schema Information
#
# Table name: order_items
#
#  id            :bigint           not null, primary key
#  order_count   :integer
#  delivery_date :datetime
#  product_id    :bigint
#  order_id      :bigint
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class OrderItem < ApplicationRecord
  belongs_to :product
  belongs_to :order
  belongs_to :supplier

  has_one :inspection, dependent: :destroy

  validates :order_count, numericality: {only_integer: true, less_than_or_equal_to: 9999999}

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
    ["商品名", "JANコード", "取引先名", "納品予定日", "納品予定数", "検品数", "最終検品日"]
  end

  # TODO: deal with jan_code
  def csv_column_values
    [product.name, product.jan_code, supplier.name, delivery_date.to_date, order_count,
      inspection.inspection_count, inspection.last_inspection.try(:to_date)]
  end

  scope :get_order_item, lambda {|store_id, jan_code|
    joins("inner join orders on order_items.order_id = orders.id
      inner join products on order_items.product_id = products.id")
      .where("orders.store_id = ? AND orders.inspected = 0 AND products.jan_code = ?", store_id, jan_code)
      .order(:order_date)
  }
end
