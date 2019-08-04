class DevicesController < ApplicationController
  before_action :set_device, only: [:edit, :update, :destroy]

  def index
    @devices = @store.devices
                     .search(params[:search_name], params[:search_number])
                     .order(number: :asc)
                     .page(params[:page]).per(100)
  end

  def new
    @device = Device.new
  end

  def edit
  end

  def create
    @device = Device.new(device_params)

    respond_to do |format|
      if @device.save
        # TODO: Change to Japanese
        format.html { redirect_to devices_url(store_id: @store.id), notice: 'Device was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @device.update(device_params)
        format.html { redirect_to devices_url(store_id: @store.id), notice: 'Device was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @device.destroy
    respond_to do |format|
      format.html { redirect_to devices_url(store_id: @store.id), notice: 'Device was successfully destroyed.' }
    end
  end

  private
    def set_device
      # TODO: set store after implemented menu and user management
      @device = Device.find(params[:id])
    end

    def device_params
      params.require(:device).permit(:name, :encrypted_password, :store_id)
    end
end
