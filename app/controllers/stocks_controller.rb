class StocksController < ApplicationController
  before_action :set_stock, only: [:edit, :update, :destroy]

  skip_before_action :find_store, only: [:search_by_name, :search_by_code]

  def index
    @q = @store.stocks.search
    if params[:q].present?
      @q = @store.stocks.search(params[:q])
      @stocks = @q.result
                  .includes(:product).order("products.jan_code asc")
                  .page(params[:page]).per(100)
    else
      # TODO: Set store
      @stocks = @store.stocks
                     .includes(:product).order("products.jan_code asc")
                     .page(params[:page]).per(100)
    end
  end

  def new
    @stock = Stock.new
  end

  def create
    @stock = Stock.new(stock_params)

    respond_to do |format|
      if @stock.save
        format.html { redirect_to stocks_url(store_id: @store.id), notice: 'Stock was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @stock.update(stock_params)
        format.html { redirect_to stocks_url(store_id: @store.id), notice: 'Stock was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @stock.destroy
    respond_to do |format|
      format.html { redirect_to stocks_url(store_id: @store.id), notice: 'Stock was successfully destroyed.' }
    end
  end

  def import; end

  def csv_import
    if params[:file].present? && params[:file].original_filename &&
        File.extname(params[:file].original_filename) == ".csv"
      @import = Stock.import params[:file], @store.id
      redirect_to import_stocks_url(store_id: @store.id), notice: @import.values
    else
      redirect_to import_stocks_url(store_id: @store.id), alert: "インポートするCSVファイルを選択してください"
    end
  end

  def search_by_name
    render json: Product.select(:id,:name,:jan_code).where(['name LIKE ?', "%#{params[:name]}%"]).limit(10)
  end

  def search_by_code
    render json: Product.select(:id,:name,:jan_code).where(['jan_code LIKE ?', "%#{params[:jan_code]}%"]).limit(10)
  end

  private
    def set_stock
      @stock = Stock.find(params[:id])
    end

    def stock_params
      params.require(:stock).permit(:product_id, :stock_count, :price, :store_id)
    end
end
