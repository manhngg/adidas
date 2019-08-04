if @message_groups.any?
	json.message_groups @message_groups do |message_group|
		json.id message_group.id
		json.name message_group.name
		if message_group.messages.any?
			json.messages message_group.messages.where("created_at >= ?", params[:since_date].to_date).order("created_at DESC") do |message|
				json.submit_user_name message.submit_user_name
				json.msg_text message.msg_text
				json.created_at message.created_at.strftime("%Y-%m-%d %H:%M:%S")
			end
		end
	end
else
	json.message "No message groups"
end
