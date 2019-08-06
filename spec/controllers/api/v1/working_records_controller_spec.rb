require 'rails_helper'

RSpec.describe Api::V1::WorkingRecordsController, type: :controller do
  let!(:store) { FactoryBot.create(:store) }
  let!(:user) { FactoryBot.create(:user) }
  let!(:check_in) { FactoryBot.create(:record_action) }
  let!(:leave_out) { FactoryBot.create(:record_action, name: "休憩入り")}

  describe "POST /api/v1/timesheets" do
    before do
      @token = JsonWebToken.encode(api_key: FactoryBot.create(:api_key, store_id: store.id).key_value)
      request.headers.merge!({'Authorization': @token})
    end

    it "request has status 200" do
      post "create", params: { store_id: store.id, staff_id: user.staff_id,
        action_type: check_in.id}
      expect(response.status).to eq 200
    end

    it "request has status 404" do
      post "create", params: { store_id: store.id, staff_id: nil,
        action_type: check_in.id}
      expect(response.status).to eq 404
    end
  end
end
