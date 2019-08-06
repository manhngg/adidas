class Api::V1::MessageGroupsController < Api::V1::ApiController
  before_action :authorize_request

	# GET /api/v1/message_groups
	def index
		store = Store.find(params[:store_id])
		@message_groups = store.message_groups
	end

	# GET /api/v1/msgboards/msg_all
	def show_all
		@message_groups = MessageGroup.where(id: params[:message_group_ids])
	end

	# GET /api/v1/msgboards/msg
	def show
		message_group = MessageGroup.find(params[:group_id])
		since_date = params[:since_date]
		@messages = message_group.messages.where("created_at >= ?", since_date.to_date).order(created_at: "DESC")
	end

	# POST /api/v1/msgboards/msg
	def create
		@message = Message.new(
			submit_user_name: params[:submit_user_name],
			msg_text: params[:msg_text],
			message_group_id: params[:group_id]
		)
	end
end
