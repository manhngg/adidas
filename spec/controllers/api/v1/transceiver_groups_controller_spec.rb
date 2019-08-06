require 'rails_helper'

RSpec.describe Api::V1::TransceiverGroupsController, type: :controller do
	let(:store) { FactoryBot.create(:store) }
	let(:transceiver_group) { FactoryBot.create(:transceiver_group, store: store) }

	describe "GET /api/v1/transceiver_groups" do
    before do
      @token = JsonWebToken.encode(api_key: FactoryBot.create(:api_key, store_id: store.id).key_value)
      request.headers.merge!({'Authorization': @token})
    end

		it "request has status 200" do
			get "index", format: :json, params: { store_id: store.id }
			expect(response.status).to eq 200
		end
	end
end
