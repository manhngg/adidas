class AdminsController < BaseController
  before_action :set_admin, only: [:edit, :update, :destroy, :permissions_set, :permissions_update, :store_permissions_set, :store_permissions_update]

  skip_before_action :find_store

  skip_authorization_check only: [:search_by_prefecture, :search_by_area]

  def index
    @q = Admin.search
    if params[:q].present?
      @q = Admin.search(params[:q])
      @admins = @q.result
                  .order(staff_id: :asc)
                  .page(params[:page]).per(100)
    else
      @admins = Admin.all
                     .order(staff_id: :asc)
                     .page(params[:page]).per(100)
    end
  end

  def new
    @admin = Admin.new
  end

  def edit
  end

  def create
    @admin = Admin.new(admin_params)

    respond_to do |format|
      if @admin.save
        format.html {redirect_to admins_url, notice: t("flash.create", name: "管理ユーザー") }
      else
        format.html {render :new}
      end
    end
  end

  def update
    respond_to do |format|
      if @admin.update(admin_params)
        format.html {redirect_to admins_url, notice: t("flash.update", name: "管理ユーザー") }
      else
        format.html {render :edit}
      end
    end
  end

  def destroy
    @admin.destroy
    respond_to do |format|
      format.html {redirect_to admins_url, notice: t("flash.destroy", name: "管理ユーザー") }
    end
  end

  def import
  end

  def csv_import
    if params[:file].present? && params[:file].original_filename &&
        File.extname(params[:file].original_filename) == ".csv"
      import = Admin.import params[:file]
      redirect_to import_admins_url
      flash[:notice] = import.values.first
      flash[:alert] = import.values.reject{|value| value == import.values.first}
    else
      redirect_to import_admins_url, notice: t("flash.csv_not_found")
    end
  end

  def permissions_set
    all_permissions = []
    %w(User WorkingRecord Device).each do |klass|
      %w(onlyread update).each do |action|
        all_permissions.push({klass: klass, action: action})
      end
    end
    %w(Admin Product Store).each do |klass|
      all_permissions.push({klass: klass, action: 'manage'})
    end

    @ability = Ability.new(@admin)
  end

  def permissions_update
    @admin.system_admin = params[:admin][:system_admin]
    ActiveRecord::Base.transaction do
      @admin.permissions.destroy_all
      @admin.permissions.build(permit_permissions)
    end

    if @admin.save
      redirect_to admins_path
    else
      render :permissions_set
    end
  end

  def store_permissions_set
    @q = Store.ransack(params.fetch(:q, prefecture_id_eq: Prefecture.first.id, area_id_eq: Prefecture.first.areas.first.id))
    @stores = @q.result
                .includes(:region).order("regions.id asc")
                .includes(:prefecture).order("prefectures.id asc")
                .includes(:area).order("areas.id asc")
                .page(params[:page]).per(100)
    @ability = Ability.new(@admin)
  end

  def store_permissions_update
    params[:stores].each do |store_id, perms|
      AdminManageStore.where(admin_id: @admin.id, store_id: store_id).destroy_all
      perms.each do |perm|
        if perm[1] == "1"
          AdminManageStore.create(
            admin_id: @admin.id,
            store_id: store_id,
            action: perm[0]
          )
        end
      end
    end
    redirect_to admins_path
  end

  def search_by_prefecture
    render json: Prefecture.select(:id, :name).where(['name LIKE ?', "%#{params[:name]}%"]).as_json.map {|x| {id: x['id'], name: x['name'], text: x['name']}}
  end

  def search_by_area
    render json: Area.select(:id, :name).where(['name LIKE ?', "%#{params[:name]}%"]).where(prefecture_id: params[:prefecture]).as_json.map {|x| {id: x['id'], name: x['name'], text: x['name']}}
  end

  def search_stores
    @stores = Store.joins(area: [:prefecture]).select('areas.name as area_name,prefectures.name as prefecture_name').select('stores.*')
    if params[:prefecture_id].present?
      @stores = @stores.where(areas: {prefecture_id: params[:prefecture_id]})
    end
    if params[:area_id].present?
      @stores = @stores.where(area_id: params[:area_id])
    end
    render json: {status: 200, data: @stores.all.as_json}
  end

  def admin_panel
    redirect_to root_path unless admin_signed_in?
  end

  private
    def set_admin
      @admin = Admin.find(params[:id])
    end

    def admin_params
      params.require(:admin).permit(:staff_id,
                                    :first_name,
                                    :last_name,
                                    :last_name_furigana,
                                    :first_name_furigana,
                                    :department,
                                    :password,
                                    :password_confirmation,
                                    store_ids: [])
    end

    def permit_permissions
      permissions = []
      params.require(:admin)[:permissions].each do |k, perms|
        perms.uniq.each do |perm|
          permissions.push({klass: k, action: perm})
        end
      end
      permissions
    end
end
