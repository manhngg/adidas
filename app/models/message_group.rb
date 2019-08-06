# == Schema Information
#
# Table name: message_groups
#
#  id         :bigint           not null, primary key
#  name       :string(255)
#  store_id   :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class MessageGroup < ApplicationRecord
  belongs_to :store, optional: true

  has_many :messages, dependent: :destroy

  validates :name, presence: true
end
