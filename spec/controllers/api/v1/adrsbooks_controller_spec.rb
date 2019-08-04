require 'rails_helper'

RSpec.describe Api::V1::AdrsbooksController, type: :controller do
  let(:store) { FactoryBot.create(:store) }
  let(:adrsbook_subcategory) {FactoryBot.create(:adrsbook_subcategory)}

  describe "GET /api/v1/adrsbooks" do
    before do
      FactoryBot.create(:adrsbook, store: store,
        adrsbook_subcategory: adrsbook_subcategory)
    end

    it "request has status 200" do
      get "index", format: :json, params: { store_id: store.id }
      expect(response.status).to eq 200
    end

    it "request has status 404" do
      get "index", params: { store_id: nil }
      expect(response.status).to eq 404
    end
  end
end
