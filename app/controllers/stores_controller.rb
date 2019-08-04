class StoresController < ApplicationController
  before_action :set_store, only: [:edit, :update, :destroy]

  skip_before_action :find_store

  def index
    @q = Store.search
    if params[:q].present?
      @q = Store.search(params[:q])
      @stores = @q.result
                  .includes(:region).order("regions.id asc")
                  .includes(:prefecture).order("prefectures.id asc")
                  .includes(:area).order("areas.id asc")
                  .page(params[:page]).per(100)
    else
      @stores = Store.all
                     .includes(:region).order("regions.id asc")
                     .includes(:prefecture).order("prefectures.id asc")
                     .includes(:area).order("areas.id asc")
                     .page(params[:page]).per(100)
    end
  end

  def new
    @store = Store.new
  end

  def edit
  end

  def create
    @store = Store.new(store_params)

    respond_to do |format|
      if @store.save
        # TODO: Change to Japanese
        format.html { redirect_to stores_url, notice: 'Store was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @store.update(store_params)
        format.html { redirect_to stores_url, notice: 'Store was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    # TODO: for users
    @store.destroy
    respond_to do |format|
      format.html { redirect_to stores_url, notice: 'Store was successfully destroyed.' }
    end
  end

  def prefs_select
    render partial: 'prefecture', locals: { region_id: params[:region_id] }
  end

  def search_prefs_select
    render partial: 'search_prefecture', locals: { region_id: params[:region_id] }
  end

  def areas_select
    render partial: 'area', locals: { prefecture_id: params[:prefecture_id] }
  end

  def search_areas_select
    render partial: 'search_area', locals: { prefecture_id: params[:prefecture_id] }
  end

  def import
  end

  def csv_import
    if params[:file].present? && params[:file].original_filename &&
        File.extname(params[:file].original_filename) == ".csv"
      import = Store.import params[:file]
      redirect_to import_stores_url, notice: import.values
    else
      redirect_to import_stores_url, alert: "インポートするCSVファイルを選択してください"
    end
  end

  private
    def set_store
      @store = Store.find(params[:id])
    end

    def store_params
      params.require(:store).permit(:name, :region_id, :prefecture_id, :area_id)
    end
end
