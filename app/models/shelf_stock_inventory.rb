class ShelfStockInventory < ApplicationRecord
  belongs_to :inventory
  belongs_to :product_inventory
end
