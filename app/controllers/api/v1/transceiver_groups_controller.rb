class Api::V1::TransceiverGroupsController < Api::V1::ApiController
  before_action :authorize_request

	# GET /api/v1/transceiver_groups
	def index
		store = Store.find(params[:store_id])
		@transceiver_groups = store.transceiver_groups
	end

  # PATCH /api/v1/transceiver_groups
  def device_update
    transceiver_group_id = TransceiverGroup.find(params[:transceiver_group_id]).id
    device = Device.find_by(number: params[:device_id])
    device.update_attributes(transceiver_group_id: transceiver_group_id)
    render json: { status: 200 }
  end

  # GET /api/v1/sippeers
  def check_sip_id
    sip_id = Device.find_by(number: params[:sip_id])
    if sip_id
      render json: { "is_exists": 1 }
    else
      render json: { "is_exists": 0 }
    end
  end
end
