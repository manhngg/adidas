class Api::V1::TransceiverGroupsController < ApplicationController
  before_action :authorize_request

	# GET /api/v1/transceiver_groups
	def index
		store = Store.find(params[:store_id])
		@transceiver_groups = store.transceiver_groups
		render json: @transceiver_groups
	end
end
