class Order < ApplicationRecord
  belongs_to :supplier
  belongs_to :store

  has_many :order_items
  has_many :inspections

  validates :order_number, presence: true, numericality: {only_integer: true}

  enum inspected: [:not_inspect, :done_inspect]
end
