class SuppliersController < ApplicationController
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
      # TODO: Set store
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
    # TODO: change to katagana
    @supplier = Supplier.new(supplier_params)

    respond_to do |format|
      if @supplier.save
        # TODO: Change to Japanese
        format.html { redirect_to suppliers_url, notice: 'Supplier was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    # TODO: change to katagana
    respond_to do |format|
      if @supplier.update(supplier_params)
        format.html { redirect_to suppliers_url, notice: 'Supplier was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @supplier.destroy
    respond_to do |format|
      format.html { redirect_to suppliers_url, notice: 'Supplier was successfully destroyed.' }
    end
  end

  def import; end

  def csv_import
    if params[:file].present? && params[:file].original_filename &&
        File.extname(params[:file].original_filename) == ".csv"
      import = Supplier.import params[:file]
      redirect_to import_suppliers_url, notice: import.values
    else
      redirect_to import_suppliers_url, alert: "インポートするCSVファイルを選択してください"
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
