class ShelvesController < ApplicationController
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
        # TODO: Change to Japanese
        format.html { redirect_to shelves_url(store_id: @store.id), notice: 'Shelf was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @shelf.update(shelf_params)
        format.html { redirect_to shelves_url(store_id: @store.id), notice: 'Shelf was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @shelf.destroy
    respond_to do |format|
      format.html { redirect_to shelves_url(store_id: @store.id), notice: 'Shelf was successfully destroyed.' }
    end
  end

  def import
  end

  def csv_import
    if params[:file].present? && params[:file].original_filename &&
        File.extname(params[:file].original_filename) == ".csv"
      @import = Shelf.import(params[:file], @store.id)
      redirect_to import_shelves_url(store_id: @store.id), notice: @import.values
    else
      redirect_to import_shelves_url(store_id: @store.id), alert: "インポートするCSVファイルを選択してください"
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
