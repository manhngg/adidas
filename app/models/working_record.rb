# == Schema Information
#
# Table name: working_records
#
#  id               :bigint           not null, primary key
#  action_time      :datetime
#  user_id          :bigint
#  record_action_id :bigint
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class WorkingRecord < ApplicationRecord
  belongs_to :user
  belongs_to :store, optional: true
  belongs_to :record_action
end
