# == Schema Information
#
# Table name: inspections
#
#  id               :bigint           not null, primary key
#  inspection_count :integer
#  staff_name       :string(255)
#  device_number    :string(255)
#  order_item_id    :bigint
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Inspection < ApplicationRecord
  belongs_to :order_item
  belongs_to :order

  # TODO: fix validation
  # validates :inspection_count, numericality: {only_integer: true}
  # validates :staff_name, :device_number, presence: true
  validates_uniqueness_of :order_item_id, on: :create
end
