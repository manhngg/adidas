class MessageGroupsController < BaseController
  before_action :set_message_group, only: [:edit, :update, :destroy]

  load_and_authorize_resource

  def edit
  end

  def update
    respond_to do |format|
      if @message_group.update(message_group_params)
        format.html { redirect_to groups_url(store_id: @store.id), notice: t("flash.update", name: "掲示板グループ") }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @message_group.destroy
    respond_to do |format|
      format.html { redirect_to groups_url(store_id: @store.id), notice: t("flash.destroy", name: "掲示板グループ") }
    end
  end

  private
    def set_message_group
      @message_group = @store.message_groups.find(params[:id])
    end

    def message_group_params
      params.require(:message_group).permit(:name, :store_id)
    end
end
