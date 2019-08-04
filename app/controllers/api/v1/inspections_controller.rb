class Api::V1::InspectionsController < ApplicationController
  include SerializableUrl

  skip_before_action :verify_authenticity_token, only: :update

  before_action :authorize_request
  before_action :find_store, only: :list_order
  before_action :find_order, only: :show_order

  # GET /api/v1/inspections
  def list_order
    @orders = @store.orders.not_inspect
  end

  # POST /api/v1/inspections
  def update
    inspections = params[:_json]
    @list_error = []
    inspections.each do |inspection|
      update_inspection inspection
    end
    if @list_error.blank?
      render json: {status: 200}, status: 200
    else
      render json: {status: 200, error: @list_error}, status: 200
    end
  end

  # GET /api/v1/inspections/{order_id}
  def show_order
    render json: set_url(@order, "Api::V1::Inspections::ShowOrder::OrderSerializer"),
           status: 200 if @order
  end

  def show_order_item
    @product = Product.find_by_jan_code(params[:jan_code])
    @order = Order.where(inspected: false).order("created_at ASC").first
    @order_item = @order.order_items.includes(:product).where(products: { jan_code: params[:jan_code] }).first
  end

  private

  def inspections_params
    params.permit :order_item_id, :inspection_count, :staff_name, :device_number
  end

  def find_store
    @store = Store.find_by_id params[:store_id]
    render json: {message: "店舗が見つかりません"}, status: 404 unless @store
  end

  def find_order
    @order = Order.find_by_id params[:order_id]
    render json: {message: "注文が見つかりません"}, status: 404 unless @order
  end

  def update_inspection param
    @store = Store.find_by_id param[:store_id]
    if @store.blank?
      @list_error << "Jan code " + param[:jan_code] + ": 店舗が見つかりません"
      return
    end

    product = Product.where(jan_code: param[:jan_code])
    if product.blank?
      @list_error << "Jan code " + param[:jan_code] + ":  JANなし"
      @store.inspection_errors.no_record.create(
        inspection_date: Time.now,
        inspection_count: param[:inspection_count],
        jan_code: param[:jan_code]
      )
      return
    end

    order_item = OrderItem.get_order_item(param[:store_id], param[:jan_code]).first
    if order_item.present?
      @inspection = order_item.inspection
      if @inspection.present?
        is_update = @inspection.update_attributes(
          inspection_count: param[:inspection_count],
          staff_name: param[:staff_name],
          device_number: param[:device_number]
        )
        unless is_update
          @list_error << "Jan code #{param[:jan_code]}: #{@inspection.errors.full_messages[0]}"
        end
      else
        @inspection = Inspection.new(
          inspection_count: param[:inspection_count],
          staff_name: param[:staff_name],
          device_number: param[:device_number],
          order_id: order_item.order.id,
          order_item_id: order_item.id
        )
        unless @inspection.save
          @list_error << "Jan code #{param[:jan_code]}: #{@inspection.errors.full_messages[0]}"
        end
      end
      order_item.order.update_attributes(last_inspection: Time.now)
    else
      @list_error << "Jan code " + param[:jan_code] + ": 発注なし"
      @store.inspection_errors.no_order.create(
        inspection_date: Time.now,
        inspection_count: param[:inspection_count],
        jan_code: param[:jan_code]
      )
    end
  end
end
