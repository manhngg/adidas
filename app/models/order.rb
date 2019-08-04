# == Schema Information
#
# Table name: orders
#
#  id           :bigint           not null, primary key
#  order_date   :datetime
#  order_number :string(255)
#  supplier_id  :bigint
#  store_id     :bigint
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Order < ApplicationRecord
  belongs_to :supplier
  belongs_to :store
  has_many :inspections, dependent: :destroy
  has_many :order_items, dependent: :destroy
  accepts_nested_attributes_for :order_items,
                                allow_destroy: true,
                                reject_if: lambda { |attrs| attrs['delivery_date'].blank? }

  # TODO: have affect to API
  enum inspected: { unfinished: 0, finished: 1 }
  # enum inspected: [:not_inspect, :done_inspect]

  validates :order_number, presence: true, numericality: {only_integer: true, less_than_or_equal_to: 9999999}

  def self.import file, store
    imported = {num: 0}
    CSV.foreach(file.path, headers: true, encoding: 'Shift_JIS:UTF-8') do |row|
      row = row.to_hash
      supplier = Supplier.find_by(supplier_number: row["supplier_number"])
      if supplier.blank?
        imported["#{$.}"] = "行#{$.}: Supplier not found"
        break
      end

      product = Product.find_by(jan_code: row["jan_code"])
      if product.blank?
        imported["#{$.}"] = "行#{$.}: Product not found"
        break
      end

      order = store.orders.find_by(order_number: row["order_number"])

      if order.blank?
        order = store.orders.new supplier_id: supplier.id, order_number: row["order_number"]
        order_item = order.order_items.find_by(product_id: product.id)
        unless order_item
          order.order_items.new delivery_date: row["delivery_date"], order_count: row["order_count"],
            supplier_id: supplier.id, product_id: product.id
        end
      end
      if order.save
        imported[:num] += 1
      else
        imported["#{$.}"] = "行#{$.}: #{order.errors.full_messages.first}"
      end
    end

    imported[:num] = imported[:num].to_s + "件、作成しました"
    imported
  end

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
    ["発注NO", "取引先名", "納品予定日", "納品予定数", "検品数", "最終検品日"]
  end

  def csv_column_values
    [order_number, supplier.name, order_date.to_date, order_count, inspection_count, last_inspection.to_date]
  end
end
