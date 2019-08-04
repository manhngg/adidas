class MessageGroupsController < ApplicationController
  before_action :set_message_group, only: [:edit, :update, :destroy]

  load_and_authorize_resource

  def edit
  end

  def update
    respond_to do |format|
      if @message_group.update(message_group_params)
        format.html { redirect_to groups_url(store_id: @store.id), notice: 'Groups was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @message_group.destroy
    respond_to do |format|
      format.html { redirect_to groups_url(store_id: @store.id), notice: 'Groups was successfully destroyed.' }
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
