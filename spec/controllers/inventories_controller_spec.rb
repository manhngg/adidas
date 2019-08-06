require 'rails_helper'

RSpec.describe InventoriesController, type: :controller do
  describe 'GET #index' do
    let(:inventories) { create_list(:inventory, 1) }
    before { get :index }

    it 'has a 200 status code' do
      expect(response).to have_http_status(:ok)
    end

    it 'assigns @shelves' do
      expect(assigns(:inventories)).to match_array inventories
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

    it 'assigns new @inventory' do
      expect(assigns(:inventory)).to be_a_new Inventory
    end

    it 'renders the :new template' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    let(:inventory_attributes) { attributes_for(:inventory) }

    it 'saves new inventory' do
      expect do
        post :create, params: { inventory: inventory_attributes }
      end.to change(Inventory, :count).by(1)
    end

    it 'redirects the :create template' do
      post :create, params: { inventory: inventory_attributes }
      expect(response).to redirect_to(inventories_path)
    end
  end
end
