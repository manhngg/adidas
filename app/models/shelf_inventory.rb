class ShelfInventory < ApplicationRecord
  belongs_to :inventory

  validates :shelf_name, presence: true
end
