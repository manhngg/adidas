class GroupsController < BaseController

  def index
    if params[:type].present? && params[:type] == "message"
      if params[:name]
        @message_groups = @store.message_groups.where(['name LIKE ?', "%#{params[:name]}%"])
      else
        @message_groups = @store.message_groups
      end
      @groups = @message_groups
    elsif params[:type].present? && params[:type] == "transceiver"
      if params[:name]
        @transceiver_groups = @store.transceiver_groups.where(['name LIKE ?', "%#{params[:name]}%"])
      else
        @transceiver_groups = @store.transceiver_groups
      end
      @groups = @transceiver_groups
    else
      if params[:name]
        @message_groups = @store.message_groups.where(['name LIKE ?', "%#{params[:name]}%"])
        @transceiver_groups = @store.transceiver_groups.where(['name LIKE ?', "%#{params[:name]}%"])
      else
        @message_groups = @store.message_groups
        @transceiver_groups = @store.transceiver_groups
      end
      @groups = @message_groups + @transceiver_groups
    end
    @groups = Kaminari.paginate_array(@groups).page(params[:page]).per(100)
    authorize! :read, MessageGroup
  end

  def new
    @group = @store.message_groups.new
  end

  def create
    if params[:type] == "message"
      @group = @store.message_groups.new(name: params[:name])
    elsif params[:type] == "transceiver"
      @group = @store.transceiver_groups.new(name: params[:name])
    end
    respond_to do |format|
      if @group.save
        format.html { redirect_to groups_url(store_id: @store.id), notice: t("flash.create", name: "グループ") }
      else
        format.html { render :new }
      end
    end
  end
end
