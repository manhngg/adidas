class ApiKey < ApplicationRecord
  belongs_to :store
  validates :key_name, presence: true
  validates :key_value, presence: true
end
