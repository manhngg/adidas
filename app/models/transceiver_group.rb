# == Schema Information
#
# Table name: transceiver_groups
#
#  id         :bigint           not null, primary key
#  sip_id     :string(255)
#  name       :string(255)
#  store_id   :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class TransceiverGroup < ApplicationRecord
  # TODO: set store
  belongs_to :store, optional: true

  has_many :devices, dependent: :destroy

  validates :name, :sip_id, presence: true

  before_validation :generate_sip_id

  # TODO: confirm the rule
  def generate_sip_id
    self.sip_id = "12345678901234"
  end
end
