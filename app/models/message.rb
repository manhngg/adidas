# == Schema Information
#
# Table name: messages
#
#  id               :bigint           not null, primary key
#  submit_user_name :string(255)
#  msg_text         :string(255)
#  message_group_id :bigint
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Message < ApplicationRecord
  belongs_to :message_group

  validates :submit_user_name, :msg_text, presence: true
end
