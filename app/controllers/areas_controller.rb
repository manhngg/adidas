class AreasController < BaseController
  before_action :set_area, only: [:edit, :update, :destroy]

  skip_before_action :find_store

  def index
    @q = Area.search
    if params[:q].present?
      @q = Area.search(params[:q])
      @areas = @q.result
                   .includes(:region).order("regions.id asc")
                   .includes(:prefecture).order("prefectures.id asc")
                   .page(params[:page]).per(100)
    else
      @areas = Area.all
                   .includes(:region).order("regions.id asc")
                   .includes(:prefecture).order("prefectures.id asc")
                   .page(params[:page]).per(100)
    end
  end

  def new
    @area = Area.new
  end

  def edit
  end

  def create
    @area = Area.new(area_params)

    respond_to do |format|
      if @area.save
        format.html { redirect_to areas_url, notice: t("flash.create", name: "エリア") }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @area.update(area_params)
        format.html { redirect_to areas_url, notice: t("flash.update", name: "エリア") }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @area.destroy
    respond_to do |format|
      format.html { redirect_to areas_url, notice: t("flash.destroy", name: "エリア") }
    end
  end

  def prefs_select
    render partial: 'prefecture', locals: { region_id: params[:region_id] }
  end

  def search_prefs_select
    render partial: 'search_prefecture', locals: { region_id: params[:region_id] }
  end

  def import; end

  def csv_import
    if params[:file].present? && params[:file].original_filename &&
        File.extname(params[:file].original_filename) == ".csv"
      import = Area.import params[:file]
      redirect_to import_areas_url, notice: import.values
    else
      redirect_to import_areas_url, alert: t("flash.csv_not_found")
    end
  end

  private
    def set_area
      @area = Area.find(params[:id])
    end

    def area_params
      params.require(:area).permit(:name, :region_id, :prefecture_id)
    end
end
