class TransceiverGroupsController < ApplicationController
  before_action :set_transceiver_group, only: [:edit, :update, :destroy]

  load_and_authorize_resource

  def edit
  end

  def update
    respond_to do |format|
      if @transceiver_group.update(transceiver_group_params)
        format.html { redirect_to groups_url(store_id: @store.id), notice: 'Groups was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @transceiver_group.destroy
    respond_to do |format|
      format.html { redirect_to groups_url(store_id: @store.id), notice: 'Groups was successfully destroyed.' }
    end
  end

  private
    def set_transceiver_group
      @transceiver_group = @store.transceiver_groups.find(params[:id])
    end

    def transceiver_group_params
      params.require(:transceiver_group).permit(:name, :store_id)
    end
end
