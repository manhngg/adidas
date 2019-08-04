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

class MessageGroupSerializer < ActiveModel::Serializer
  attributes :id, :name
	has_many :messages

	def messages
		object.messages.order("created_at DESC").first
	end

	class MessageSerializer < ActiveModel::Serializer
		attributes :submit_user_name, :msg_text, :created_at

		def created_at
			object.created_at.strftime("%Y-%m-%d %H:%M:%S")
		end
	end
end
