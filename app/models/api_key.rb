# == Schema Information
#
# Table name: api_keys
#
#  id         :bigint           not null, primary key
#  key_name   :string(255)
#  key_value  :string(255)
#  store_id   :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ApiKey < ApplicationRecord
  belongs_to :store
  validates :key_name, presence: true
  validates :key_value, presence: true
end
