class Api::V1::InventoriesController < ApplicationController
  include SerializableUrl

  skip_before_action :verify_authenticity_token, only: [:update_product_inventory, :update_start, :update_finish]

  before_action :authorize_request
  before_action :find_store, only: [:list_shelf, :update_start, :update_finish]

  # GET /api/v1/inventories
  def list_shelf
    @shelves = @store.shelves
    if @shelves.present?
      render json: set_url(@shelves, "Api::V1::Inventories::ListShelf::ShelfSerializer"),
             status: 200
    else
      render json: {message: "失敗レスポンス"}, status: 500
    end
  end

  # POST /api/v1/inventories
  def update_product_inventory
    list_param = params[:_json]
    @list_error = []
    list_param.each do |param|
      update_item_product_inventory param
    end
    if @list_error.blank?
      render json: {status: 200}, status: 200
    else
      render json: {error: @list_error}, status: 500
    end
  end

  # POST /api/v1/inventories/start
  def update_start
    update_status_shelf_inventory CONSTANT::STATUS_START
  end

  # POST /api/v1/inventories/finish
  def update_finish
    update_status_shelf_inventory CONSTANT::STATUS_FINISH
  end

  private

  def find_store
    @store = Store.find_by_id params[:store_id]
    render json: {message: "店舗が見つかりません"}, status: 404 unless @store
  end

  def find_inventory
    @inventory = @store.inventories.find_by_status(CONSTANT::STATUS_NOT_START)
    render json: {message: "在庫が見つかりません"}, status: 404 unless @inventory
  end

  def find_shelf_inventory
    shelf_name = @store.shelves.find_by_id(params[:shelf_id]).try(:name)
    @shelf_inventory = @inventory.shelf_inventories.find_by_shelf_name(shelf_name)
    render json: {message: "棚在庫が見つかりません"}, status: 404 unless @shelf_inventory
  end

  def update_item_product_inventory item
    store = Store.find_by_id item[:store_id]
    product_inventory = store.product_inventories.find_by_jan_code item[:jan_code]
    unless product_inventory
      @list_error << "Row #{item[:row]} and col #{item[:col]}: 商品在庫が見つかりません"
      return false
    end
    product = store.products.find_by_jan_code item[:jan_code]
    unless product
      @list_error << "Row #{item[:row]} and col #{item[:col]}: 商品が見つかりません"
      false
    end
    stock = store.stocks.find_by_product_id product.id
    stock_count = stock.stock_count
    if product_inventory.try(:shelf_stock_inventories)
      inventory_count = product_inventory.shelf_stock_inventories.sum :inventory_count
    end
    unmatched_flag = (inventory_count == stock_count) ? 0 : 1
    diff_number = inventory_count - stock_count

    shelf_stock_inventory = product_inventory.shelf_stock_inventories.new(
      shelf_name: item[:shelf_name],
      row: item[:row].to_i,
      col: item[:col].to_i,
      inventory_count: item[:inventory_count],
      inventory_time: Time.now,
      staff_name: item[:staff_name],
      device_number: item[:device_number],
      inventory_id: product_inventory.inventory.id,
      product_inventory_id: product_inventory.id
    ) if product_inventory

    unless shelf_stock_inventory.save
      @list_error << "Row #{item[:row]} and col #{item[:col]}: 失敗レスポンス"
      return false
    end

    product_inventory.update_attributes(
      inventory_count: inventory_count,
      unmatched_flag: unmatched_flag,
      inventory_time: Time.now,
      diff_number: diff_number
    )
  end

  def update_status_shelf_inventory status
    shelf_name = @store.shelves.find_by_id(params[:shelf_id]).try(:name)
    unless shelf_name
      render json: {message: "失敗レスポンス"}, status: 500
      return
    end

    inventories = @store.inventories.where(status: CONSTANT::STATUS_NOT_START)
    inventories.each do |inventory|
      shelf_inventory = inventory.shelf_inventories.find_by_shelf_name(shelf_name)
      is_update = shelf_inventory.update_attributes(
        staff_name: params[:name],
        device_number: params[:device_number],
        start_time: Time.current,
        status: status
      ) if shelf_inventory

      next unless is_update
    end
    render json: {status: "200"}, status: 200
  end
end
