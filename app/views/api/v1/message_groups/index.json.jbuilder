if @message_groups.any?
  json.message_groups @message_groups do |message_group|
    json.id message_group.id
    json.name message_group.name
    if message_group.messages.any?
      json.messages do
        json.submit_user_name message_group.messages.order("created_at DESC")
          .first.submit_user_name
        json.msg_text message_group.messages.order("created_at DESC")
          .first.msg_text
        json.created_at message_group.messages.order("created_at DESC")
          .first.created_at.strftime("%Y-%m-%d %H:%M:%S")
      end
    end
  end
else
  json.message "No message groups"
end
