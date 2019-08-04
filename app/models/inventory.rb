class Inventory < ApplicationRecord
  belongs_to :store

  has_many :shelf_inventories
  has_many :product_inventories
  has_many :shelf_stock_inventories
end
