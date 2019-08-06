class InspectionsController < BaseController
  before_action :set_order, only: [:show, :finished_status]

  def index
    @q = @store.orders.search
    if params[:q].present?
      @q = @store.orders.search(params[:q])
      @orders = @q.result
                  .order(order_date: :asc)
                  .page(params[:page]).per(100)
    else
      @orders = @store.orders.order(order_date: :asc).page(params[:page]).per(100)
    end

    if params[:export_csv]
      send_data @orders.to_csv, filename: "検品結果一覧リスト#{Time.current.strftime('%Y%m%d')}.csv"
    else
      render :index
    end
  end

  def show
    @q = @order.order_items.search
    if params[:q].present?
      @q = @order.order_items.search(params[:q])
      @order_items = @q.result
                    .page(params[:page]).per(100)
    else
      @order_items = @order.order_items
                           .order(product_id: :asc)
                           .page(params[:page]).per(100)
    end

    if params[:export_csv]
      send_data @order_items.to_csv, filename: "検品結果詳細リスト#{Time.current.strftime('%Y%m%d')}.csv"
    else
      render :show
    end
  end

  def finished_status
    @order.finished!

    redirect_to inspections_url(store_id: @store.id), notice: t("flash.update", name: "ステータス")
  end

  private
    def set_order
      @order = @store.orders.find(params[:id])
    end
end
