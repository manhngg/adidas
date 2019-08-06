if @company
	if @api_key
		# json.message "Success"
		# json.id @company.id
    json.company do
		  json.name @company.name
		  json.subdomain @company.subdomain
		  json.token @token
    end
	else
	  json.message "Failed"
	end
else
	json.message "Failed"
end
