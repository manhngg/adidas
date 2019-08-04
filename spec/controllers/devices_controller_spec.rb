require 'rails_helper'

RSpec.describe DevicesController, type: :controller do
  describe 'GET #index' do
    let(:devices) { create_list(:device, 3) }
    before { get :index }

    it 'has a 200 status code' do
      expect(response).to have_http_status(:ok)
    end

    it 'assigns @devices' do
      expect(assigns(:devices)).to match_array devices
    end

    it 'renders the :index template' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #new' do
    before { get :new }

    it 'has a 200 status code' do
      expect(response).to have_http_status(:ok)
    end

    it 'assigns new @device' do
      expect(assigns(:device)).to be_a_new Device
    end

    it 'renders the :new template' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    let(:device_attributes) { attributes_for(:device) }

    it 'saves new device' do
      expect do
        post :create, params: { device: device_attributes }
      end.to change(Device, :count).by(1)
    end

    it 'redirects the :create template' do
      post :create, params: { device: device_attributes }
      expect(response).to redirect_to(devices_path)
    end
  end

  describe 'GET #edit' do
    let(:device) { create(:device) }
    before { get :edit, params: { id: device.id } }

    it 'has a 200 status code' do
      expect(response).to have_http_status(:ok)
    end

    it 'assigns @device' do
      expect(assigns(:device)).to eq device
    end

    it 'renders the :edit template' do
      expect(response).to render_template :edit
    end
  end

  describe 'PATCH #update' do
    let!(:device) { create(:device) }
    let(:update_attributes) do
      {
          name: 'update name',
          encrypted_password: 'update encrypted_password'
      }
    end

    it 'saves updated device' do
      expect do
        patch :update, params: { id: device.id, device: update_attributes }
      end.to change(Device, :count).by(0)
    end

    it 'updates updated device' do
      patch :update, params: { id: device.id, device: update_attributes }
      device.reload
      expect(device.name).to eq update_attributes[:name]
      expect(device.encrypted_password).to eq update_attributes[:encrypted_password]
    end

    it 'redirects the :create template' do
      patch :update, params: { id: device.id, device: update_attributes }
      expect(response).to redirect_to(devices_path)
    end
  end

  describe 'DELETE #destroy' do
    let!(:device) { create(:device) }
    it 'deletes the device' do
      expect do
        delete :destroy, params: { id: device.id }
      end.to change(Device, :count).by(-1)
    end

    it 'redirects the :create template' do
      delete :destroy, params: { id: device.id }
      expect(response).to redirect_to(devices_path)
    end
  end
end
