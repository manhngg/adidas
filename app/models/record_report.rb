class RecordReport < ApplicationRecord
  belongs_to :user
  belongs_to :store

  validates :record_date, presence: true
end
