class AdrsbooksController < BaseController
  before_action :find_adrsbook, only: [:edit, :update, :destroy]
  before_action :load_adrsbook_subcategories,
    only: [:index, :new, :create, :edit, :update]

  load_and_authorize_resource

  def index
    @q = @store.adrsbooks.ransack params[:q]
    if @q
      @adrsbooks = @q.result.page(params[:page]).per(100)
    else
      @adrsbooks = @store.adrsbooks.page(params[:page]).per(100)
    end
  end

  def new
    @adrsbook = Adrsbook.new
  end

  def create
    @adrsbook = Adrsbook.new adrsbook_params

    if @adrsbook.save
      redirect_to adrsbooks_path(store_id: @store.id), notice: t("flash.create", name: "電話帳")
    else
      render :new
    end
  end

  def edit; end

  def update
    if @adrsbook.update adrsbook_params
      redirect_to adrsbooks_path(store_id: @store.id), notice: t("flash.update", name: "電話帳")
    else
      render :new
    end
  end

  def destroy
    if @adrsbook.destroy
      redirect_to adrsbooks_path(store_id: @store.id), notice: t("flash.destroy", name: "電話帳")
    end
  end

  def import; end

  def csv_import
    if params[:file].present? && params[:file].original_filename &&
        File.extname(params[:file].original_filename) == ".csv"
      import = Adrsbook.import params[:file], @store.id
      redirect_to import_adrsbooks_url(store_id: @store.id)
      flash[:notice] = import.values.first
      flash[:alert] = import.values.reject{|value| value == import.values.first}
    else
      redirect_to import_adrsbooks_url(store_id: @store.id),
        notice: t("flash.csv_not_found")
    end
  end

  private

  def adrsbook_params
    params.require(:adrsbook).permit Adrsbook::ATTRIBUTE_PARAMS
  end

  def load_adrsbook_subcategories
    @adrsbook_subcategories = AdrsbookSubcategory.all
      .map do |adrsbook_subcategory|
      [adrsbook_subcategory.name, adrsbook_subcategory.id]
    end
  end

  def find_adrsbook
    @adrsbook = Adrsbook.find_by id: params[:id]

    return if @adrsbook
    redirect_to adrsbooks_path, notice: t("flash.not_found", name: "電話帳")
  end
end
