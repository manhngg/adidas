class InventoriesController < ApplicationController
  before_action :set_inventory, only: [:show_shelf, :show_product, :show_shelf_stock, :toggle_done, :show_error]

  def index
    @q = @store.inventories.search
    if params[:q].present?
      @q = @store.inventories.search(params[:q])
      @inventories = @q.result
                       .order(start_time: :desc)
                       .page(params[:page]).per(100)
    else
      # TODO: Set store
      @inventories = @store.inventories
                           .order(start_time: :desc)
                           .page(params[:page]).per(100)
    end
  end

  def new
    @inventory = @store.inventories.new
  end

  def create
    @inventory = @store.inventories.new(inventory_params)

    respond_to do |format|
      if @inventory.save
        format.html { redirect_to inventories_url(store_id: @store.id), notice: 'Inventory was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def toggle_done
    @inventory.done!

    redirect_to inventories_url(store_id: @store.id), notice: 'Status was successfully updated!'
  end

  def show_shelf
    @shelf_inventories = @inventory.shelf_inventories
                                   .order(finish_time: :desc)
                                   .page(params[:page]).per(100)
  end

  def show_product
    @q = @inventory.product_inventories.search
    if params[:q].present?
      if params[:super_search]
        # TODO: set store for inventory so we can get product_inventory
        @q = @inventory.product_inventories.search(params[:q])
        @product_inventories = @q.result
                                   .order(unmatched_flag: :desc)
                                   .order(inventory_time: :desc)
                                   .page(params[:page]).per(100)
      else
        @q = @inventory.product_inventories.search(params[:q])
        @product_inventories = @q.result
                                   .order(unmatched_flag: :desc)
                                   .order(inventory_time: :desc)
                                   .page(params[:page]).per(100)
      end
    else
      @product_inventories = @inventory.product_inventories.all
                                                           .order(unmatched_flag: :desc)
                                                           .order(inventory_time: :desc)
                                                           .page(params[:page]).per(100)
    end

    @stock_sum_price = @product_inventories.select(:price, :stock_count).map{|x| x.price * x.stock_count}.sum
    @inventory_sum_price = @product_inventories.select(:price, :inventory_count).where.not(inventory_count: nil).map{|x| x.price * x.inventory_count}.sum
    @minus_price = @inventory_sum_price - @stock_sum_price

    if params[:export_csv]
      send_data @product_inventories.to_csv, filename: "棚卸実査照合リスト#{Time.current.strftime('%Y%m%d')}.csv"
    else
      render :show_product
    end
  end

  def show_shelf_stock
    @product_inventory = @inventory.product_inventories.find(params[:product_inventory_id])
    @shelf_stock_inventories = @product_inventory.shelf_stock_inventories
                                   .order(inventory_time: :desc)
                                   .page(params[:page]).per(100)

    respond_to do |format|
      format.html
      format.csv do
        send_data render_to_string, filename: "棚卸実査照合詳細リスト#{Time.current.strftime('%Y%m%d')}.csv", type: :csv
      end
    end
  end

  def show_error
    @shelf_stock_inventories = @inventory.shelf_stock_inventories
                                         .where.not(error_type: 0)
                                         .order(inventory_time: :desc)
                                         .page(params[:page]).per(100)
  end

  private
    def set_inventory
      @inventory = @store.inventories.find(params[:id])
    end

    def inventory_params
      params.require(:inventory).permit(:start_time, :store_id)
    end
end
