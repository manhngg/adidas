class ShelvesController < BaseController
  before_action :set_shelf, only: [:edit, :update, :destroy]

  def index
    @shelves = @store.shelves.search(params[:search_name])
                    .page(params[:page]).per(100)
  end

  def new
    @shelf = Shelf.new
  end

  def edit
  end

  def create
    @shelf = Shelf.new(shelf_params)

    respond_to do |format|
      if @shelf.save
        format.html { redirect_to shelves_url(store_id: @store.id), notice: t("flash.create", name: "棚") }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @shelf.update(shelf_params)
        format.html { redirect_to shelves_url(store_id: @store.id), notice: t("flash.update", name: "棚") }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @shelf.destroy
    respond_to do |format|
      format.html { redirect_to shelves_url(store_id: @store.id), notice: t("flash.destroy", name: "棚") }
    end
  end

  def import
  end

  def csv_import
    if params[:file].present? && params[:file].original_filename &&
        File.extname(params[:file].original_filename) == ".csv"
      import = Shelf.import(params[:file], @store.id)
      redirect_to import_shelves_url(store_id: @store.id)
      flash[:notice] = import.values.first
      flash[:alert] = import.values.reject{|value| value == import.values.first}
    else
      redirect_to import_shelves_url(store_id: @store.id), notice: t("flash.csv_not_found")
    end
  end

  private
    def set_shelf
      # TODO: Set store
      @shelf = Shelf.find(params[:id])
    end

    def shelf_params
      params.require(:shelf).permit(:name, :row_count, :col_count, :store_id)
    end
end
