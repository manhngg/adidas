if @messages.any?
  json.messages @messages do |message|
    json.submit_user_name message.submit_user_name
    json.msg_text message.msg_text
    json.created_at message.created_at.strftime("%Y-%m-%d %H:%M:%S")
  end
else
  json.message "No message"
end
