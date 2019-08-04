class OrdersController < ApplicationController
  before_action :set_order, only: [:edit, :update, :destroy]

  load_and_authorize_resource

  def index
    @q = @store.orders.search
    if params[:q].present?
      @q = @store.orders.search(params[:q])
      @orders = @q.result
                  .includes(:supplier)
                  .order(order_date: :asc)
                  .page(params[:page]).per(100)

    else
      # TODO: Set store
      @orders = @store.orders.includes(:supplier)
                     .order(order_date: :asc)
                     .page(params[:page]).per(100)
    end
  end

  def new
    @order = @store.orders.new
    @order_items = @order.order_items.build
  end

  def edit
    @order_items = @order.order_items.includes(:supplier, :product)
  end

  def create
    @order = @store.orders.new hash_order_params
    respond_to do |format|
      if @order.save
        # TODO: Change to Japanese
        format.html { redirect_to orders_url(store_id: @store.id), notice: 'Order was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @order.update hash_order_params
        format.html { redirect_to orders_url(store_id: @store.id), notice: 'Order was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url(store_id: @store.id), notice: 'Order was successfully destroyed.' }
    end
  end

  def import; end

  def csv_import
    if params[:file].present? && params[:file].original_filename &&
        File.extname(params[:file].original_filename) == ".csv"
      import = @store.orders.import(params[:file], @store)
      redirect_to import_orders_url(store_id: @store.id), notice: import.values
    else
      redirect_to import_orders_url(store_id: @store.id), alert: "インポートするCSVファイルを選択してください"
    end
  end

  private

  def create_product_ids
    params[:name].each_with_index.map do |param_name, index|
      Product.find_by(name: param_name, jan_code: params[:jan_code][index])&.id
    end
  end

  def hash_order_params
    @order_params = order_params
    @order_params[:order_items_attributes].each_with_index do |(key,value), index|
      value.merge!(product_id: create_product_ids[index])
    end
    @order_params
  end

  def set_order
    @order = @store.orders.find(params[:id])
  end

  def order_params
    if params.require(:order)[:order_items_attributes].present?
      first_record = params.require(:order)[:order_items_attributes].values.sort_by{|x|Time.parse(x['delivery_date'])}.first
      hash = params.require(:order).permit(:store_id, :order_number, order_items_attributes: [:id, :supplier_id, :delivery_date, :product_id, :order_count, :_destroy]).to_h
      hash.merge!({order_date:first_record['delivery_date'],supplier_id: first_record['supplier_id'],order_count:first_record['order_count']})
    else
      params.require(:order).permit(:store_id, :order_number, order_items_attributes: [:id, :supplier_id, :delivery_date, :product_id, :order_count, :_destroy])
    end
  end
end
