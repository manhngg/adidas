require 'rails_helper'

RSpec.describe AreasController, type: :controller do
  describe 'GET #index' do
    let(:areas) { create_list(:area, 3) }
    before { get :index }

    it 'has a 200 status code' do
      expect(response).to have_http_status(:ok)
    end

    it 'assigns @areas' do
      expect(assigns(:areas)).to match_array areas
    end

    it 'renders the :index template' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #edit' do
    let(:area) { create(:area) }
    before { get :edit, params: { id: area.id } }

    it 'has a 200 status code' do
      expect(response).to have_http_status(:ok)
    end

    it 'assigns @area' do
      expect(assigns(:area)).to eq area
    end

    it 'renders the :edit template' do
      expect(response).to render_template :edit
    end
  end

  describe 'PATCH #update' do
    let!(:area) { create(:area) }
    let(:update_attributes) do
      {
          name: '新しいエリア'
      }
    end

    it 'saves updated area' do
      expect do
        patch :update, params: { id: area.id, area: update_attributes }
      end.to change(Area, :count).by(0)
    end

    it 'updates updated area' do
      patch :update, params: { id: area.id, area: update_attributes }
      area.reload
      expect(area.name).to eq update_attributes[:name]
    end

    it 'redirects the :create template' do
      patch :update, params: { id: area.id, area: update_attributes }
      expect(response).to redirect_to(areas_path)
    end
  end

  describe 'DELETE #destroy' do
    let!(:area) { create(:area) }
    it 'deletes the area' do
      expect do
        delete :destroy, params: { id: area.id }
      end.to change(Area, :count).by(-1)
    end

    it 'redirects the :create template' do
      delete :destroy, params: { id: area.id }
      expect(response).to redirect_to(areas_path)
    end
  end
end
