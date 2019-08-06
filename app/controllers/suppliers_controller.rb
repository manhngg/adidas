class SuppliersController < BaseController
  before_action :set_supplier, only: [:edit, :update, :destroy]

  skip_before_action :find_store

  def index
    @q = Supplier.search
    if params[:q].present?
      @q = Supplier.search(params[:q])
      @suppliers = @q.result
                     .order(supplier_number: :asc)
                     .page(params[:page]).per(100)
    else
      @suppliers = Supplier.all
                           .order(supplier_number: :asc)
                           .page(params[:page]).per(100)
    end
  end

  def new
    @supplier = Supplier.new
  end

  def edit
  end

  def create
    @supplier = Supplier.new(supplier_params)

    respond_to do |format|
      if @supplier.save
        format.html { redirect_to suppliers_url, notice: t("flash.create", name: "取引先") }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @supplier.update(supplier_params)
        format.html { redirect_to suppliers_url, notice: t("flash.update", name: "取引先") }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @supplier.destroy
    respond_to do |format|
      format.html { redirect_to suppliers_url, notice: t("flash.destroy", name: "取引先") }
    end
  end

  def import; end

  def csv_import
    if params[:file].present? && params[:file].original_filename &&
        File.extname(params[:file].original_filename) == ".csv"
      import = Supplier.import params[:file]
      redirect_to import_suppliers_url
      flash[:notice] = import.values.first
      flash[:alert] = import.values.reject{|value| value == import.values.first}
    else
      redirect_to import_suppliers_url, notice: t("flash.csv_not_found")
    end
  end

  private
    def set_supplier
      @supplier = Supplier.find(params[:id])
    end

    def supplier_params
      params.require(:supplier).permit(:supplier_number, :name, :furigana)
    end
end
