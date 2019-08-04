require 'rails_helper'
RSpec.describe Api::V1::InventoriesController, type: :controller do
  describe "GET /api/v1/inventories" do
    let!(:store) {FactoryBot.create(:store)}
    let!(:store_new) {FactoryBot.create(:store)}
    let!(:shelf) {FactoryBot.create(:shelf, store: store)}

    it "request has status 200" do
      get "list_shelf", params: {store_id: store.id}
      expect(response.status).to eq 200
    end

    it "request has status 500" do
      get "list_shelf", params: {store_id: store_new.id}
      expect(response.status).to eq 500
    end

    it "request has status 404" do
      get "list_shelf", params: {store_id: nil}
      expect(response.status).to eq 404
    end
  end

  describe "POST /api/v1/inventories" do
    let!(:store_first) {FactoryBot.create(:store)}
    let!(:inventory_first) {FactoryBot.create(:inventory, store: store_first)}
    let!(:shelf_inventory_first) {FactoryBot.create(:shelf_inventory, inventory: inventory_first)}
    let!(:product_first) {FactoryBot.create(:product)}
    let!(:stock_first) {FactoryBot.create(:stock, store: store_first, product: product_first)}
    let!(:product_inventory_first) {FactoryBot.create(:product_inventory,
      jan_code: product_first.jan_code, inventory: inventory_first)}
    let!(:store_second) {FactoryBot.create(:store)}
    let!(:inventory_second) {FactoryBot.create(:inventory, store: store_second)}
    let!(:shelf_inventory_second) {FactoryBot.create(:shelf_inventory, inventory: inventory_second)}
    let!(:product_second) {FactoryBot.create(:product)}
    let!(:stock_second) {FactoryBot.create(:stock, store: store_second, product: product_second)}
    let!(:product_inventory_second) {FactoryBot.create(:product_inventory,
      inventory: inventory_second, jan_code: product_second.jan_code)}

    it "request has status 200" do
      list_params = {
        _json: [
          {
            store_id: store_first.id,
            jan_code: product_first.jan_code,
            shelf_name: shelf_inventory_first.shelf_name,
            row: rand(1..1000),
            col: rand(1..1000),
            stock_count: rand(100...1000),
            inventory_count: rand(100...1000),
            device_number: rand(100...1000),
            staff_name: FFaker::Name.name
          },
          {
            store_id: store_second.id,
            jan_code: product_second.jan_code,
            shelf_name: shelf_inventory_second.shelf_name,
            row: rand(1..1000),
            col: rand(1..1000),
            stock_count: rand(100...1000),
            inventory_count: rand(100...1000),
            device_number: rand(100...1000),
            staff_name: FFaker::Name.name
          }
        ]
      }
      post "update_product_inventory", params: list_params
      expect(response.status).to eq 200
    end

    it "request has status 500" do
      list_params = {
        _json: [
          {
            store_id: store_first.id,
            jan_code: product_second.jan_code,
            shelf_name: shelf_inventory_first.shelf_name,
            row: rand(1..1000),
            col: rand(1..1000),
            stock_count: rand(100...1000),
            inventory_count: rand(100...1000),
            device_number: rand(100...1000),
            staff_name: FFaker::Name.name
          }
        ]
      }
      post "update_product_inventory", params: list_params
      expect(response.status).to eq 500
    end
  end

  describe "POST /api/v1/inventories/start" do
    let!(:store) {FactoryBot.create(:store)}
    let!(:store_new) {FactoryBot.create(:store)}
    let!(:shelf) {FactoryBot.create(:shelf, store: store)}
    let!(:inventory) {FactoryBot.create(:inventory, store: store)}
    let!(:shelf_inventory) {FactoryBot.create(:shelf_inventory, shelf_name: shelf.name, inventory: inventory)}
    let!(:shelf_inventory_new) {FactoryBot.create(:shelf_inventory, inventory: inventory)}

    it "request has status 200" do
      post "update_start",
        params: {store_id: store.id, shelf_id: shelf.id,
          device_number: rand(100...1000), name: FFaker::Name.name}
      expect(response.status).to eq 200
    end

    it "request has status 404" do
      post "update_start", params: {store_id: nil}
      expect(response.status).to eq 404
    end
  end

  describe "POST /api/v1/inventories/finish" do
    let!(:store) {FactoryBot.create(:store)}
    let!(:store_new) {FactoryBot.create(:store)}
    let!(:shelf) {FactoryBot.create(:shelf, store: store)}
    let!(:inventory) {FactoryBot.create(:inventory, store: store)}
    let!(:shelf_inventory) {FactoryBot.create(:shelf_inventory, shelf_name: shelf.name, inventory: inventory)}

    it "request has status 200" do
      post "update_finish",
        params: {store_id: store.id, shelf_id: shelf.id,
          device_number: rand(100...1000), name: FFaker::Name.name}
      expect(response.status).to eq 200
    end

    it "request has status 404" do
      post "update_finish", params: {store_id: nil}
      expect(response.status).to eq 404
    end
  end
end
