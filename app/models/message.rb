class Message < ApplicationRecord
  belongs_to :message_group

  validates :submit_user_name, :msg_text, presence: true
end
