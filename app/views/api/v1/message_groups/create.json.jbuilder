if @message.save
  json.status "Success"
  json.message do
    json.submit_user_name @message.submit_user_name
    json.msg_text @message.msg_text
    json.created_at @message.created_at.strftime("%Y-%m-%d %H:%M:%S")
  end
else
  json.status "Fail"
  json.message nil
end
