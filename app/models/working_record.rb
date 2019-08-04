class WorkingRecord < ApplicationRecord
  belongs_to :user
  belongs_to :record_action
end
