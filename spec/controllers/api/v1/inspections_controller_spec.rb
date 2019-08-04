require 'rails_helper'

RSpec.describe Api::V1::InspectionsController, type: :controller do
  describe "GET /api/v1/inspections" do
    let!(:store) {FactoryBot.create(:store)}
    let!(:store_new) {FactoryBot.create(:store)}
    let!(:supplier) {FactoryBot.create(:supplier)}
    let!(:product) {FactoryBot.create(:product)}
    let!(:order) {FactoryBot.create(:order, store: store, supplier: supplier)}
    let!(:order_item) {FactoryBot.create(:order_item, order_id: order.id,
      product: product, supplier: supplier)}
    let!(:inspections) {FactoryBot.create(:inspection, order_item: order_item, order: order)}

    it "request has status 200" do
      get "list_order", params: {store_id: store.id}
      expect(response.status).to eq 200
    end

    it "request has status 500" do
      get "list_order", params: {store_id: store_new.id}
      expect(response.status).to eq 500
    end

    it "request has status 404" do
      get "list_order", params: {store_id: nil}
      expect(response.status).to eq 404
    end
  end

  describe "POST /api/v1/inspections" do
    let!(:store) {FactoryBot.create(:store)}
    let!(:store_new) {FactoryBot.create(:store)}
    let!(:supplier) {FactoryBot.create(:supplier)}
    let!(:product) {FactoryBot.create(:product)}
    let!(:stock) {FactoryBot.create(:stock, product: product, store: store)}
    let!(:order) {FactoryBot.create(:order, store: store, supplier: supplier)}
    let!(:order_item_first) {FactoryBot.create(:order_item, order_id: order.id,
      product: product, supplier: supplier)}
    let!(:order_item_second) {FactoryBot.create(:order_item, order_id: order.id,
      product: product, supplier: supplier)}

    it "request has status 200" do
      list_params = {
        _json: [
          {
            inspection_count: 5,
            staff_name: FFaker::Name.name,
            device_number: rand(1...50),
            jan_code: order_item_first.product.jan_code
          },
          {
            inspection_count: 5,
            staff_name: FFaker::Name.name,
            device_number: rand(1...50),
            jan_code: order_item_second.product.jan_code
          }
        ],
        store_id: store.id
      }
      post "create", params: list_params
      expect(response.status).to eq 200
    end

    it "request has status 500" do
      list_params = {
        _json: [
          {
            inspection_count: 5,
            staff_name: FFaker::Name.name,
            device_number: rand(1...50),
            jan_code: nil
          },
          {
            inspection_count: 5,
            staff_name: FFaker::Name.name,
            device_number: rand(1...50),
            jan_code: nil
          }
        ],
        store_id: store_new.id
      }
      post "create", params: list_params
      expect(response.status).to eq 500
    end
  end

  describe "GET /api/v1/inspections/{order_id}" do
    let!(:store) {FactoryBot.create(:store)}
    let!(:store_new) {FactoryBot.create(:store)}
    let!(:supplier) {FactoryBot.create(:supplier)}
    let!(:product) {FactoryBot.create(:product)}
    let!(:order) {FactoryBot.create(:order, store: store, supplier: supplier)}
    let!(:order_item) {FactoryBot.create(:order_item, order_id: order.id,
      product: product, supplier: supplier)}
    let!(:inspections) {FactoryBot.create(:inspection, order_item: order_item,
      order: order)}

    it "request has status 200" do
      get "show_order", params: {order_id: order.id}
      expect(response.status).to eq 200
    end

    it "request has status 404" do
      get "show_order", params: {order_id: 0}
      expect(response.status).to eq 404
    end
  end
end
