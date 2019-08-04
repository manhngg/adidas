require 'rails_helper'

RSpec.describe Api::V1::MessageGroupsController, type: :controller do
	let(:store) { FactoryBot.create(:store) }
	let(:message_group) { FactoryBot.create(:message_group, store: store) }

	describe "GET /api/v1/message_groups" do
		it "request has status 200" do
			get "index", params: { store_id: store.id }
			expect(response.status).to eq 200
		end
	end

	describe "GET /api/v1/msgboards/newest" do
		it "request has status 200" do
			get "newest", params: { message_group_ids: [1, 2] }
			expect(response.status).to eq 200
		end
	end

	describe "Get /api/v1/msgboards/msg" do
		it "request has status 200" do
			get "show", params: { group_id: message_group.id, since_date: "20190610" }
			expect(response.status).to eq 200
		end
	end

	describe "POST /api/v1/msgboards/msg" do
		it "request has status 200" do
			post "create", params: { group_id: message_group.id, submit_user_name: "Toan", msg_text: "Hello" }
			expect(response.status).to eq 200
		end
	end
end
