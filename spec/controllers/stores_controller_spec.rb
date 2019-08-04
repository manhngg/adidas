require 'rails_helper'

RSpec.describe StoresController, type: :controller do
  describe 'GET #index' do
    let(:stores) { create_list(:store, 3) }
    before { get :index }

    it 'has a 200 status code' do
      expect(response).to have_http_status(:ok)
    end

    it 'assigns @stores' do
      expect(assigns(:stores)).to match_array stores
    end

    it 'renders the :index template' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #edit' do
    let(:store) { create(:store) }
    before { get :edit, params: { id: store.id } }

    it 'has a 200 status code' do
      expect(response).to have_http_status(:ok)
    end

    it 'assigns @store' do
      expect(assigns(:store)).to eq store
    end

    it 'renders the :edit template' do
      expect(response).to render_template :edit
    end
  end

  describe 'PATCH #update' do
    let!(:store) { create(:store) }
    let(:update_attributes) do
      {
          name: '新しい店舗名'
      }
    end

    it 'saves updated store' do
      expect do
        patch :update, params: { id: store.id, store: update_attributes }
      end.to change(Store, :count).by(0)
    end

    it 'updates updated store' do
      patch :update, params: { id: store.id, store: update_attributes }
      store.reload
      expect(store.name).to eq update_attributes[:name]
    end

    it 'redirects the :create template' do
      patch :update, params: { id: store.id, store: update_attributes }
      expect(response).to redirect_to(stores_path)
    end
  end

  describe 'DELETE #destroy' do
    let!(:store) { create(:store) }
    it 'deletes the store' do
      expect do
        delete :destroy, params: { id: store.id }
      end.to change(Store, :count).by(-1)
    end

    it 'redirects the :create template' do
      delete :destroy, params: { id: store.id }
      expect(response).to redirect_to(stores_path)
    end
  end
end
