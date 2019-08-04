class OrderItem < ApplicationRecord
  belongs_to :product
  belongs_to :order
  belongs_to :supplier

  has_one :inspection
  validates :order_count, numericality: {only_integer: true}

  scope :get_order_item, lambda {|store_id, jan_code|
    joins("inner join orders on order_items.order_id = orders.id
      inner join products on order_items.product_id = products.id")
      .where("orders.store_id = ? AND orders.inspected = 0 AND products.jan_code = ?", store_id, jan_code)
      .order(:order_date)
  }
end
