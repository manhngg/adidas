require 'rails_helper'

RSpec.describe StocksController, type: :controller do
  describe 'GET #index' do
    let(:stocks) { create_list(:stock, 3) }
    before { get :index }

    it 'has a 200 status code' do
      expect(response).to have_http_status(:ok)
    end

    it 'assigns @stocks' do
      expect(assigns(:stocks)).to match_array stocks
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

    it 'assigns new @stock' do
      expect(assigns(:stock)).to be_a_new Stock
    end

    it 'renders the :new template' do
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    let(:stock) { create(:stock) }
    before { get :edit, params: { id: stock.id } }

    it 'has a 200 status code' do
      expect(response).to have_http_status(:ok)
    end

    it 'assigns @stock' do
      expect(assigns(:stock)).to eq stock
    end

    it 'renders the :edit template' do
      expect(response).to render_template :edit
    end
  end

  describe 'PATCH #update' do
    let!(:stock) { create(:stock) }
    let(:update_attributes) do
      {
          stock_count: 555,
          price: 999
      }
    end

    it 'saves updated stock' do
      expect do
        patch :update, params: { id: stock.id, stock: update_attributes }
      end.to change(Stock, :count).by(0)
    end

    it 'updates updated stock' do
      patch :update, params: { id: stock.id, stock: update_attributes }
      stock.reload
      expect(stock.stock_count).to eq update_attributes[:stock_count]
      expect(stock.price).to eq update_attributes[:price]
    end

    it 'redirects the :create template' do
      patch :update, params: { id: stock.id, stock: update_attributes }
      expect(response).to redirect_to(stocks_path)
    end
  end

  describe 'DELETE #destroy' do
    let!(:stock) { create(:stock) }
    it 'deletes the stock' do
      expect do
        delete :destroy, params: { id: stock.id }
      end.to change(Stock, :count).by(-1)
    end

    it 'redirects the :create template' do
      delete :destroy, params: { id: stock.id }
      expect(response).to redirect_to(stocks_path)
    end
  end
end
