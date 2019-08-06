class ProductsController < BaseController
  before_action :set_product, only: [:edit, :update, :destroy]

  skip_before_action :find_store

  def index
    @products = Product.search(params[:search_name], params[:search_jan])
                       .order(jan_code: :asc)
                       .page(params[:page]).per(100)
  end

  def new
    @product = Product.new
  end

  def edit
  end

  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to products_url, notice: t("flash.create", name: "商品") }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to products_url, notice: t("flash.update", name: "商品") }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: t("flash.destroy", name: "商品") }
    end
  end

  def import; end

  def csv_import
    if params[:file].present? && params[:file].original_filename &&
        File.extname(params[:file].original_filename) == ".csv"
      import = Product.import params[:file]
      redirect_to import_products_url
      flash[:notice] = import.values.first
      flash[:alert] = import.values.reject{|value| value == import.values.first}
    else
      redirect_to import_products_url, notice: t("flash.csv_not_found")
    end
  end

  private
    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:name, :jan_code)
    end
end
