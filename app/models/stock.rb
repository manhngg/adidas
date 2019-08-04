# == Schema Information
#
# Table name: stocks
#
#  id          :bigint           not null, primary key
#  stock_count :integer
#  price       :integer
#  store_id    :bigint
#  product_id  :bigint
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Stock < ApplicationRecord
  belongs_to :store
  belongs_to :product

  validates :stock_count, :price, numericality: {only_integer: true, less_than_or_equal_to: 9999999}

  class << self
    def import file, store_id
      imported = {num: 0}
      CSV.foreach(file.path, headers: true, encoding: 'Shift_JIS:UTF-8') do |row|
        row = row.to_hash
        if product = Product.find_by(jan_code: row["jan_code"])
          stock = product.stocks.build store_id: store_id, stock_count: row["stock_count"], price: row["price"]
          if stock.save
            imported[:num] += 1
          else
            imported["#{$.}"] = "行#{$.}: #{stock.errors.full_messages.first}"
          end
        else
          imported[:error] = "商品が見つかりません"
        end
      end
      imported[:num] = imported[:num].to_s + "件、作成しました"
      imported
    end
  end
end
