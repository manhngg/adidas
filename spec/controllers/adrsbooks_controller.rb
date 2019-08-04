require 'rails_helper'

RSpec.describe AdrsbooksController, type: :controller do
  let!(:adrsbook) {FactoryBot.create(:adrsbook)}
  let!(:adrsbooks) { create_list(:adrsbook, 3) }
  describe 'GET #index' do
    before { get :index }
    it 'has a 200 status code' do
      expect(response).to have_http_status(:ok)
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
    it 'assigns new @adrsbook' do
      expect(assigns(:adrsbook)).to be_a_new Adrsbook
    end
    it 'renders the :new template' do
      expect(response).to render_template :new
    end
  end
  describe 'POST #create' do
    let(:adrsbook_attributes) { attributes_for(:adrsbook) }
    it 'create new adrsbook' do
      expect do
        post :create, params: { adrsbook: adrsbook_attributes }
      end
    end
  end
  describe 'GET #edit' do
    let(:adrsbook) { create(:adrsbook) }
    before { get :edit, params: { id: adrsbook.id } }
    it 'has a 200 status code' do
      expect(response).to have_http_status(:ok)
    end
    it 'assigns @shelf' do
      expect(assigns(:adrsbook)).to eq adrsbook
    end
    it 'renders the :edit template' do
      expect(response).to render_template :edit
    end
  end
  describe 'PATCH #update' do
    let!(:adrsbook) { create(:adrsbook) }
    let(:update_attributes) do
      {
          name: '新しい棚名',
      }
    end
    it 'saves updated shelf' do
      expect do
        patch :update, params: { id: adrsbook.id, adrsbook: update_attributes }
      end.to change(Adrsbook, :count).by(0)
    end
    it 'updates updated shelf' do
      patch :update, params: { id: adrsbook.id, adrsbook: update_attributes }
      adrsbook.reload
      expect(adrsbook.name).to eq update_attributes[:name]
    end
    it 'redirects the :create template' do
      patch :update, params: { id: adrsbook.id, adrsbook: update_attributes }
      expect(response).to redirect_to(adrsbooks_path)
    end
  end
  describe 'DELETE #destroy' do
    let!(:adrsbook) { create(:adrsbook) }
    it 'deletes the shelf' do
      expect do
        delete :destroy, params: { id: adrsbook.id }
      end.to change(Adrsbook, :count).by(-1)
    end
    it 'redirects the :create template' do
      delete :destroy, params: { id: adrsbook.id }
      expect(response).to redirect_to(adrsbooks_path)
    end
  end
end
