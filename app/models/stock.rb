class Stock < ApplicationRecord
  belongs_to :store
  belongs_to :product

  validates :stock_count, numericality: {only_integer: true}
  validates :price, numericality: {only_integer: true}
end
