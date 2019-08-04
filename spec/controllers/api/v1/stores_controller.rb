require 'rails_helper'

RSpec.describe Api::V1::StoresController, type: :controller do
  let(:store) { FactoryBot.create(:store) }
  describe "GET /api/v1/stores" do
    it "request has status 200" do
      get "index"
      expect(response.status).to eq 200
    end
  end

  describe "GET /api/v1/stores/numbers/registration" do
    it "request has status 200" do
      FactoryBot.create(:device, store_id: store.id,
        encrypted_password: BCrypt::Password.create("12345678"))
      patch "registration", params: {store_id: store.id,
        number: "0", password: "12345678"}
      expect(response.status).to eq 200
    end

    it "request has status 401" do
      FactoryBot.create(:device, store_id: store.id,
        encrypted_password: BCrypt::Password.create("12345678"))
      patch "registration", params: {store_id: store.id,
        number: "0", password: "123456789"}
      expect(response.status).to eq 401
    end
  end

  describe "GET /api/v1/stores/numbers/unregistration" do
    it "request has status 200" do
      FactoryBot.create(:device, store_id: store.id)
      patch "unregistration", params: {store_id: store.id,
        number: "0"}
      expect(response.status).to eq 200
    end

  describe "GET /api/v1/stores/:id/numbers" do
    it "request has status 200" do
      FactoryBot.create(:device, store_id: store.id)
      get "numbers", params: {id: store.id}
      expect(response.status).to eq 200
    end
    it "request has status 500" do
      get "numbers", params: {id: store.id}
      expect(response.status).to eq 500
    end
  end
end
