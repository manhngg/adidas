# == Schema Information
#
# Table name: record_actions
#
#  id         :bigint           not null, primary key
#  name       :string(255)
#  order      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class RecordAction < ApplicationRecord
  has_many :working_records

  validates :name, presence: true
  validates :order, numericality: {only_integer: true}
end
