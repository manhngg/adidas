class RecordAction < ApplicationRecord
  has_many :working_records

  validates :name, presence: true
  validates :order, numericality: {only_integer: true}
end
