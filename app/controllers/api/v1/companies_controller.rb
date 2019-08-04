class Api::V1::CompaniesController < ApplicationController
	include SerializableUrl

	skip_before_action :verify_authenticity_token

	# POST /api/v1/companies/identify
	def identify
    @company = Company.where("id LIKE(?)", "%#{params[:id]}%").first
    if @company
			# Apartment::Tenant.switch!(company.subdomain)
      @api_key = ApiKey.where("key_value LIKE(?)", "%#{params[:api_key]}%").first
      if @api_key
				@token = JsonWebToken.encode(api_key: @api_key.key_value)
			end
		end
	end
end
