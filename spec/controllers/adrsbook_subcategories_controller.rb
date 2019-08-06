require 'rails_helper'

RSpec.describe AdrsbookSubcategoriesController, type: :controller do
  let!(:adrsbook_subcategory) {FactoryBot.create(:adrsbook_subcategory)}
  let!(:adrsbook_subcategories) { create_list(:adrsbook_subcategory, 3) }
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
    it 'assigns new @adrsbook_subcategory' do
      expect(assigns(:adrsbook_subcategory)).to be_a_new AdrsbookSubcategory
    end
    it 'renders the :new template' do
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    let(:adrsbook_subcategory) { create(:adrsbook_subcategory) }
    before { get :edit, params: { id: adrsbook_subcategory.id } }
    it 'has a 200 status code' do
      expect(response).to have_http_status(:ok)
    end
    it 'assigns @shelf' do
      expect(assigns(:adrsbook_subcategory)).to eq adrsbook_subcategory
    end
    it 'renders the :edit template' do
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do
    let(:adrsbook_subcategory_attributes) { attributes_for(:adrsbook_subcategory) }
    it 'create new adrsbook_subcategory' do
      expect do
        post :create, params: { adrsbook_subcategory: adrsbook_subcategory_attributes }
      end
    end
  end

  describe 'PATCH #update' do
    let!(:adrsbook_subcategory) { create(:adrsbook_subcategory) }
    let(:update_attributes) do
      {
          name: '新しい棚名',
      }
    end
    it 'saves updated shelf' do
      expect do
        patch :update, params: { id: adrsbook_subcategory.id, adrsbook_subcategory: update_attributes }
      end.to change(AdrsbookSubcategory, :count).by(0)
    end

    it 'updates updated shelf' do
      patch :update, params: { id: adrsbook_subcategory.id, adrsbook_subcategory: update_attributes }
      adrsbook_subcategory.reload
      expect(adrsbook_subcategory.name).to eq update_attributes[:name]
    end

    it 'redirects the :create template' do
      patch :update, params: { id: adrsbook_subcategory.id, adrsbook_subcategory: update_attributes }
      expect(response).to redirect_to(adrsbook_subcategories_path)
    end
  end

  describe 'DELETE #destroy' do
    let!(:adrsbook_subcategory) { create(:adrsbook_subcategory) }
    it 'deletes the shelf' do
      expect do
        delete :destroy, params: { id: adrsbook_subcategory.id }
      end.to change(AdrsbookSubcategory, :count).by(-1)
    end
    it 'redirects the :create template' do
      delete :destroy, params: { id: adrsbook_subcategory.id }
      expect(response).to redirect_to(adrsbook_subcategories_path)
    end
  end
end
