class ShelfInventory < ApplicationRecord
  belongs_to :inventory

  validates :shelf_name, presence: true

  enum status: { unstarted: 0, started: 1, done: 2 }
end
