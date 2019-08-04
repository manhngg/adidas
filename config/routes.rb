Rails.application.routes.draw do
	namespace :api, format: "json" do
		namespace :v1 do
			##### WebAPP_CommonFeature
			# GET   /api/v1/stores
			get "stores", to: "stores#index"
			# GET   /api/v1/stores/:id/numbers
			get "stores/:id/numbers", to: "stores#numbers"
			# PATCH /api/v1/stores/numbers/registration
			patch "stores/numbers/registration", to: "stores#registration"
			# PATCH /api/v1/stores/number/unregistration
			patch "stores/numbers/unregistration", to: "stores#unregistration"
			# POST  /api/v1/companies/identify
			post "companies/identify", to: "companies#identify"
			# POST  /api/v1/user_login
			post "user_login", to: "authentications#login"

			##### CommunicationAPP_GroupSettingFeature
			# GET   /api/v1/message_groups
			get "message_groups", to: "message_groups#index"
			# GET   /api/v1/transceiver_groups
			get "transceiver_groups", to: "transceiver_groups#index"

			##### CommunicationAPP_TransceiverFeature
			# PATCH /api/v1/transceiver_groups
			patch "transceiver_groups", to: "transceiver_groups#device_update"
			# GET   /api/v1/sippeers
			get "sippeers",	to: "transceiver_groups#check_sip_id"

			##### CommunicationAPP_MessageBoardFeature
			# GET   /api/v1/msgboards/msg_all
			get "msgboards/msg_all", to: "message_groups#show_all"
			# GET   /api/v1/msgboards/msg
			get "msgboards/msg", to: "message_groups#show"
			# POST  /api/v1/msgboards/msg
			post "msgboards/msg", to: "message_groups#create"

			##### CommunicationAPP_AddressBookFeature
			# GET   /api/v1/adrsbooks
			get "adrsbooks", to: "adrsbooks#index"

			##### ProductAPP_InventoryFeature
			# GET   /api/v1/inventories
			get "inventories", to: "inventories#list_shelf"
			# POST  /api/v1/inventories
			post "inventories", to: "inventories#update_product_inventory"
			# GET   /api/v1/products
			get "products", to: "products#index"
			# POST  /api/v1/inventories/start
			post "inventories/start", to: "inventories#update_start"
			# POST  /api/v1/inventories/finish
			post "inventories/finish", to: "inventories#update_finish"

			##### ProductAPP_InspectionFeature
			# GET   /api/v1/inspections
			get "inspections", to: "inspections#list_order"
			# GET   /api/v1/inspections/:order_id
			get "inspections/:order_id", to: "inspections#show_order"
			# GET   /api/v1/inspections/order_items
			get "inspections/order_items/:jan_code", to: "inspections#show_order_item"
			# POST  /api/v1/inspections
			post "inspections", to: "inspections#update"
			# GET   /api/v1/products
			
			##### StaffAPP_TimesheetFeature
			# POST  /api/v1/timesheets
			post "timesheets", to: "working_records#create"
		end
	end

	##### Health check

	# GET healthcheck
	get "healthCheck", to: "healthchecks#index"

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
