require 'rails_helper'

RSpec.describe InspectionsController, type: :controller do
  describe 'GET #index' do
    before { get :index }

    it 'has a 200 status code' do
      expect(response).to have_http_status(:ok)
    end

    it 'assigns @orders' do
      @order = create(:order)
      @order_item = create(:order_item, order: @order)
      @inspection = create(:inspection, order_item: @order_item)
      expect(assigns(:orders)).to match_array  @orders
    end

    it 'renders the :index template' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    let(:order) { create(:order) }
    before { get :show, params: { id: order.id }, session: {} }

    it 'has a 200 status code' do
      expect(response).to have_http_status(:ok)
    end

    it 'assigns @order' do
      expect(assigns(:order)).to eq order
    end

    it 'renders the :show template' do
      expect(response).to render_template :show
    end
  end
end
