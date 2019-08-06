class UsersController < BaseController
  before_action :set_user, only: [:edit, :update, :destroy, :permissions_set, :permissions_update]

  skip_authorization_check only: [:search_by_prefecture, :search_by_area]

  load_and_authorize_resource

  def index
    @q = @store.users.search
    if params[:q].present?
      @q = @store.users.search(params[:q])
      @users = @q.result
                 .order(staff_id: :asc)
                 .page(params[:page]).per(100)
    else
      @users = @store.users
                   .order(staff_id: :asc)
                   .page(params[:page]).per(100)
    end
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html {redirect_to users_url(store_id: @store.id), notice: t("flash.create", name: "ユーザー") }
      else
        format.html {render :new}
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html {redirect_to users_url(store_id: @store.id), notice: t("flash.update", name: "ユーザー") }
      else
        format.html {render :edit}
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html {redirect_to users_url(store_id: @store.id), notice: t("flash.destroy", name: "ユーザー") }
    end
  end

  def import; end

  def csv_import
    if params[:file].present? && params[:file].original_filename &&
        File.extname(params[:file].original_filename) == ".csv"
      @import = User.import(params[:file], @store.id)
      redirect_to import_users_url(store_id: @store.id), notice: @import.values
    else
      redirect_to import_users_url(store_id: @store.id), alert: t("flash.csv_not_found")
    end
  end

  def permissions_set
    all_permissions = []
    %w(User WorkingRecord Device).each do |klass|
      %w(onlyread update).each do |action|
        all_permissions.push({klass: klass, action: action})
      end
    end
    %w(User Product Store).each do |klass|
      all_permissions.push({klass: klass, action: 'manage'})
    end

    @ability = Ability.new(@user)
  end

  def permissions_update
    @user.system_user = params[:user][:system_user]
    ActiveRecord::Base.transaction do
      @user.permissions.destroy_all
      @user.permissions.build(permit_permissions)
    end

    if @user.save
      redirect_to users_path
    else
      render :permissions_set
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:staff_id,
                                   :first_name,
                                   :last_name,
                                   :last_name_furigana,
                                   :first_name_furigana,
                                   :department,
                                   :password,
                                   :password_confirmation,
                                   store_ids: [])
    end
end
