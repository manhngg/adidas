class Shelf < ApplicationRecord
  belongs_to :store

  has_many :shelf_stocks

  validates :name, presence: true
  validates :row_count, :col_count, numericality: {only_integer: true}
end
