class ProductInventory < ApplicationRecord
  belongs_to :inventory

  has_many :shelf_stock_inventories

  validates :product_name, presence: true
  validates :jan_code, presence: true, uniqueness: true,
    numericality: {only_integer: true}, length: {maximum: 13}
end
