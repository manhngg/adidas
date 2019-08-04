class TransceiverGroup < ApplicationRecord
  belongs_to :store

  has_many :devices

  validates :name, :sip_id, presence: true
end
