class Product < ApplicationRecord
  has_many :order_items
  has_many :stocks

  validates :name, presence: true
  validates :jan_code, presence: true, uniqueness: true, length: {maximum: 13}
end
