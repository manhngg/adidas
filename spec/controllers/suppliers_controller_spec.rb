require 'rails_helper'

RSpec.describe SuppliersController, type: :controller do
  describe 'GET #index' do
    let(:suppliers) { create_list(:supplier, 3) }
    before { get :index }

    it 'has a 200 status code' do
      expect(response).to have_http_status(:ok)
    end

    it 'assigns @suppliers' do
      expect(assigns(:suppliers)).to match_array suppliers
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

    it 'assigns new @supplier' do
      expect(assigns(:supplier)).to be_a_new Supplier
    end

    it 'renders the :new template' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    let(:supplier_attributes) { attributes_for(:supplier) }

    it 'saves new supplier' do
      expect do
        post :create, params: { supplier: supplier_attributes }
      end.to change(Supplier, :count).by(1)
    end

    it 'redirects the :create template' do
      post :create, params: { supplier: supplier_attributes }
      expect(response).to redirect_to(suppliers_path)
    end
  end

  describe 'GET #edit' do
    let(:supplier) { create(:supplier) }
    before { get :edit, params: { id: supplier.id } }

    it 'has a 200 status code' do
      expect(response).to have_http_status(:ok)
    end

    it 'assigns @supplier' do
      expect(assigns(:supplier)).to eq supplier
    end

    it 'renders the :edit template' do
      expect(response).to render_template :edit
    end
  end

  describe 'PATCH #update' do
    let!(:supplier) { create(:supplier) }
    let(:update_attributes) do
      {
          supplier_number: '12345678',
          name: '新しい取引先名',
          furigana: 'アタラシイカタカナ'
      }
    end

    it 'saves updated supplier' do
      expect do
        patch :update, params: { id: supplier.id, supplier: update_attributes }
      end.to change(Supplier, :count).by(0)
    end

    it 'updates updated supplier' do
      patch :update, params: { id: supplier.id, supplier: update_attributes }
      supplier.reload
      expect(supplier.supplier_number).to eq update_attributes[:supplier_number]
      expect(supplier.name).to eq update_attributes[:name]
      expect(supplier.furigana).to eq update_attributes[:furigana]
    end

    it 'redirects the :create template' do
      patch :update, params: { id: supplier.id, supplier: update_attributes }
      expect(response).to redirect_to(suppliers_path)
    end
  end

  describe 'DELETE #destroy' do
    let!(:supplier) { create(:supplier) }
    it 'deletes the supplier' do
      expect do
        delete :destroy, params: { id: supplier.id }
      end.to change(Supplier, :count).by(-1)
    end

    it 'redirects the :create template' do
      delete :destroy, params: { id: supplier.id }
      expect(response).to redirect_to(suppliers_path)
    end
  end
end
