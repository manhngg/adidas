require 'rails_helper'

RSpec.describe Api::V1::ProductsController, type: :controller do
  let!(:store) {FactoryBot.create(:store)}
  let!(:store_new) {FactoryBot.create(:store)}
  let!(:product) {FactoryBot.create(:product)}
  let!(:stock) {FactoryBot.create(:stock, product: product, store: store)}

  describe "GET /api/v1/products" do
    before do
      @token = JsonWebToken.encode(api_key: FactoryBot.create(:api_key, store_id: store.id).key_value)
      request.headers.merge!({'Authorization': @token})
    end

    it "request has status 200" do
      get "index", format: :json, params: { store_id: store.id }
      expect(response.status).to eq 200
    end

    it "request has status 500" do
      get "index", format: :json, params: { store_id: store_new.id }
      expect(response.status).to eq 500
    end

    it "request has status 404" do
      get "index", format: :json, params: { store_id: nil }
      expect(response.status).to eq 404
    end
  end
end
