class AdrsbookSubcategoriesController < BaseController
  before_action :find_adrsbook_subcategory, only: [:edit, :update, :destroy]

  load_and_authorize_resource

  def index
    params[:q] ||= {}
    @q = AdrsbookSubcategory.order(:order).ransack(params[:q])
    @adrsbook_subcategories = @q.result(distinct: true).page(params[:page]).per(100)
  end

  def new
    @adrsbook_subcategory = AdrsbookSubcategory.new
  end

  def create
    @adrsbook_subcategory = AdrsbookSubcategory.new adrsbook_subcategory_params
    if @adrsbook_subcategory.save
      redirect_to adrsbook_subcategories_path(store_id: @store.id), notice: t("flash.destroy", name: "詳細分類")
    else
      render :new
    end
  end

  def edit; end

  def update
    if @adrsbook_subcategory.update adrsbook_subcategory_params
      redirect_to adrsbook_subcategories_path(store_id: @store.id), notice: t("flash.destroy", name: "詳細分類")
    else
      render :new
    end
  end

  def destroy
    if @adrsbook_subcategory.destroy
      redirect_to adrsbook_subcategories_path(store_id: @store.id), notice: t("flash.destroy", name: "詳細分類")
    end
  end

  private

  def adrsbook_subcategory_params
    params.require(:adrsbook_subcategory).permit AdrsbookSubcategory::ATTRIBUTE_PARAMS
  end

  def find_adrsbook_subcategory
    @adrsbook_subcategory = AdrsbookSubcategory.find_by id: params[:id]
    return if @adrsbook_subcategory
    redirect_to adrsbook_subcategories_path(store_id: @store.id), alert: t("flash.not_found", name: "詳細分類")
  end
end
