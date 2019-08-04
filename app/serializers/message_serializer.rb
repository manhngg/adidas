class MessageSerializer < ActiveModel::Serializer
  attributes :submit_user_name, :msg_text, :created_at

	def created_at
		object.created_at.strftime("%Y-%m-%d %H:%M:%S")
	end
end
