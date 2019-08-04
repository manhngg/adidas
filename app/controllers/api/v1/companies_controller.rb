class Api::V1::CompaniesController < ApplicationController
	include SerializableUrl

	skip_before_action :verify_authenticity_token

	# POST /api/v1/companies/identify
	def identify
		@company = Company.find_by(id: params[:id])
		if @company
			# Apartment::Tenant.switch!(company.subdomain)
			@api_key = ApiKey.find_by(key_value: params[:api_key])
			if @api_key
				@token = JsonWebToken.encode(api_key: @api_key.key_value)
				#time = Time.now + 24.hours.to_i
			end
		end
	end
end
