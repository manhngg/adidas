require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  describe 'GET #index' do
    let(:products) { create_list(:product, 3) }
    before { get :index }

    it 'has a 200 status code' do
      expect(response).to have_http_status(:ok)
    end

    it 'assigns @products' do
      expect(assigns(:products)).to match_array products
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

    it 'assigns new @product' do
      expect(assigns(:product)).to be_a_new Product
    end

    it 'renders the :new template' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    let(:product_attributes) { attributes_for(:product) }

    it 'saves new product' do
      expect do
        post :create, params: { product: product_attributes }
      end.to change(Product, :count).by(1)
    end

    it 'redirects the :create template' do
      post :create, params: { product: product_attributes }
      expect(response).to redirect_to(products_path)
    end
  end

  describe 'GET #edit' do
    let(:product) { create(:product) }
    before { get :edit, params: { id: product.id } }

    it 'has a 200 status code' do
      expect(response).to have_http_status(:ok)
    end

    it 'assigns @product' do
      expect(assigns(:product)).to eq product
    end

    it 'renders the :edit template' do
      expect(response).to render_template :edit
    end
  end

  describe 'PATCH #update' do
    let!(:product) { create(:product) }
    let(:update_attributes) do
      {
          name: '新しい商品名',
          jan_code: '5326874569100'
      }
    end

    it 'saves updated product' do
      expect do
        patch :update, params: { id: product.id, product: update_attributes }
      end.to change(Product, :count).by(0)
    end

    it 'updates updated product' do
      patch :update, params: { id: product.id, product: update_attributes }
      product.reload
      expect(product.name).to eq update_attributes[:name]
      expect(product.jan_code).to eq update_attributes[:jan_code]
    end

    it 'redirects the :create template' do
      patch :update, params: { id: product.id, product: update_attributes }
      expect(response).to redirect_to(products_path)
    end
  end

  describe 'DELETE #destroy' do
    let!(:product) { create(:product) }
    it 'deletes the product' do
      expect do
        delete :destroy, params: { id: product.id }
      end.to change(Product, :count).by(-1)
    end

    it 'redirects the :create template' do
      delete :destroy, params: { id: product.id }
      expect(response).to redirect_to(products_path)
    end
  end
end
