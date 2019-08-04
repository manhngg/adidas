class ShelfStock < ApplicationRecord
  belongs_to :shelf
  belongs_to :stock
end
