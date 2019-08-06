require 'rails_helper'

RSpec.describe Api::V1::MessageGroupsController, type: :controller do
	let(:store) { FactoryBot.create(:store) }
	let(:message_group) { FactoryBot.create(:message_group, store: store) }

	describe "GET /api/v1/message_groups" do
    before do
      @token = JsonWebToken.encode(api_key: FactoryBot.create(:api_key, store_id: store.id).key_value)
      request.headers.merge!({'Authorization': @token})
    end

		it "request has status 200" do
			get "index", format: :json, params: { store_id: store.id }
			expect(response.status).to eq 200
		end
	end

	describe "GET /api/v1/msgboards/msg_all" do
    before do
      @token = JsonWebToken.encode(api_key: FactoryBot.create(:api_key, store_id: store.id).key_value)
      request.headers.merge!({'Authorization': @token})
    end

		it "request has status 200" do
			get "show_all", format: :json, params: { message_group_ids: [1, 2] }
			expect(response.status).to eq 200
		end
	end

	describe "Get /api/v1/msgboards/msg" do
    before do
      @token = JsonWebToken.encode(api_key: FactoryBot.create(:api_key, store_id: store.id).key_value)
      request.headers.merge!({'Authorization': @token})
    end

		it "request has status 200" do
			get "show", format: :json, params: { group_id: message_group.id, since_date: "20190610" }
			expect(response.status).to eq 200
		end
	end

	describe "POST /api/v1/msgboards/msg" do
    before do
      @token = JsonWebToken.encode(api_key: FactoryBot.create(:api_key, store_id: store.id).key_value)
      request.headers.merge!({'Authorization': @token})
    end

		it "request has status 200" do
			post "create", format: :json, params: { group_id: message_group.id, submit_user_name: "Toan", msg_text: "Hello" }
			expect(response.status).to eq 200
		end
	end
end
