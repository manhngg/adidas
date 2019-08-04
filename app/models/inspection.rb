class Inspection < ApplicationRecord
  belongs_to :order_item
  belongs_to :order

  # validates :inspection_count, numericality: {only_integer: true}
  # validates :staff_name, :device_number, presence: true
  validates_uniqueness_of :order_item_id, on: :create
end
