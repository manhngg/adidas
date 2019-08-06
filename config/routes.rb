Rails.application.routes.draw do
  # TODO: For Store ID after Implented User Management
  resources :devices, except: [:show]

  resources :products, except: [:show] do
    collection do
      get :import
      post :csv_import
    end
  end

  resources :groups, only: [:index, :new, :create]
  resources :message_groups, only: [:edit, :update, :destroy]
  resources :transceiver_groups, only: [:edit, :update, :destroy]

  resources :working_records, only: [:index]

  resources :record_reports, except: [:show]

  resources :inspection_errors, only: [:index]

  resources :orders do
    collection do
      get :import
      post :csv_import
    end
  end

  get 'supplier_search', to: 'order_items#supplier_search'
  get 'order_item/search_by_name', to: 'order_items#search_by_name'
  get 'order_item/search_by_code', to: 'order_items#search_by_code'

  resources :inspections do
    member do
      get :finished_status
    end
  end

  resources :suppliers, except: [:show] do
    collection do
      get :import
      post :csv_import
    end
  end

  resources :areas, except: [:show] do
    collection do
      get :prefs_select
      get :search_prefs_select
      get :import
      post :csv_import
    end
  end

  resources :stores, except: [:show] do
    collection do
      get :prefs_select
      get :search_prefs_select
      get :areas_select
      get :search_areas_select
      get :import
      post :csv_import
    end
  end

  resources :shelves, except: [:show] do
    collection do
      get :import
      post :csv_import
    end
  end

  resources :inventories, except: [:show] do
    member do
      get :shelf_inventories, to: "inventories#show_shelf"
      get :product_inventories, to: "inventories#show_product"
      get "/product_inventory/:product_inventory_id", to: "inventories#show_shelf_stock", as: :shelf_stock_inventories
      get :toggle_done
      get :errors, to: "inventories#show_error"
    end
  end

  resources :stocks, except: [:show] do
    collection do
      get :search_by_name
      get :search_by_code
      get :import
      post :csv_import
    end
  end

  resources :admins do
    member do
      get :permissions_set
      patch :permissions_update
      get :store_permissions_set
      patch :store_permissions_update
    end

    collection do
      # TODO: Refactor after store management is merged
      get :search_by_prefecture
      get :search_by_area
      get :search_stores

      get :import
      post :csv_import
    end
  end

  resources :users do
    collection do
      get :import
      post :csv_import
    end
  end

  resources :adrsbooks do
    collection do
      get :import
      post :csv_import
    end
  end

  resources :adrsbook_subcategories

  ##### API #####
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

  devise_scope :admin do
    root to: "admins/sessions#company_identify"
    # get "company_identify", to: "admins/sessions#company_identify", as: :company_identify
    post "/company_identify", to: "admins/sessions#company_identify_action", as: :company_identify_action
    get "/admin_panel", to: "admins#admin_panel", as: :admin_panel
    get "/login", to: "admins/sessions#new", as: :admin_login
    delete "/logout", to: "admins/sessions#destroy", as: :admin_logout
  end

  devise_for :admins, path: "admin_accounts", controllers: {
    sessions: "admins/sessions"
  }
end
