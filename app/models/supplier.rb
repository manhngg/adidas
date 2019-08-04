class Supplier < ApplicationRecord
  has_many :orders
  has_many :order_items

  validates :name, presence: true
  validates :supplier_number, presence: true, numericality: {only_integer: true}, length: {maximum: 20}
end
