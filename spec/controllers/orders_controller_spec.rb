require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  describe 'GET #index' do
    let(:orders) { create_list(:order, 3) }
    before { get :index }

    it 'has a 200 status code' do
      expect(response).to have_http_status(:ok)
    end

    it 'assigns @orders' do
      expect(assigns(:orders)).to match_array orders
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

    it 'assigns new @order' do
      expect(assigns(:order)).to be_a_new Order
    end

    it 'renders the :new template' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    let(:order_attributes) { attributes_for(:order) }

    it 'saves new order' do
      expect do
        post :create, params: { order: order_attributes }
      end.to change(Order, :count).by(1)
    end

    it 'redirects the :index template' do
      post :create, params: { order: order_attributes }
      expect(response).to redirect_to(orders_path)
    end
  end

  describe 'GET #edit' do
    let(:order) { create(:order) }
    before { get :edit, params: { id: order.id } }

    it 'has a 200 status code' do
      expect(response).to have_http_status(:ok)
    end

    it 'assigns @order' do
      expect(assigns(:order)).to eq order
    end

    it 'renders the :edit template' do
      expect(response).to render_template :edit
    end
  end

  describe 'PATCH #update' do
    let!(:order) { create(:order) }
    let(:update_attributes) do
      {
          order_number: '999999'
      }
    end

    it 'saves updated order' do
      expect do
        patch :update, params: { id: order.id, order: update_attributes }
      end.to change(Order, :count).by(0)
    end

    it 'updates updated order' do
      patch :update, params: { id: order.id, order: update_attributes }
      order.reload
      expect(order.order_number).to eq update_attributes[:order_number]
    end

    it 'redirects the :index template' do
      patch :update, params: { id: order.id, order: update_attributes }
      expect(response).to redirect_to(orders_path)
    end
  end

  describe 'DELETE #destroy' do
    let!(:order) { create(:order) }
    it 'deletes the order' do
      expect do
        delete :destroy, params: { id: order.id }
      end.to change(Order, :count).by(-1)
    end

    it 'redirects the :index template' do
      delete :destroy, params: { id: order.id }
      expect(response).to redirect_to(orders_path)
    end
  end
end
