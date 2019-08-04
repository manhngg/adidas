require 'rails_helper'

RSpec.describe Api::V1::TransceiverGroupsController, type: :controller do
	let(:store) { FactoryBot.create(:store) }
	let(:transceiver_group) { FactoryBot.create(:transceiver_group, store: store) }

	describe "GET /api/v1/transceiver_groups" do
		it "request has status 200" do
			get "index", params: { store_id: store.id }
			expect(response.status).to eq 200
		end
	end
end
