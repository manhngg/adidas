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

class TransceiverGroupSerializer < ActiveModel::Serializer
  attributes :id, :name, :sip_id
end
