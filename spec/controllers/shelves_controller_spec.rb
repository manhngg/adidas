require 'rails_helper'

RSpec.describe ShelvesController, type: :controller do
  describe 'GET #index' do
    let(:shelves) { create_list(:shelf, 3) }
    before { get :index }

    it 'has a 200 status code' do
      expect(response).to have_http_status(:ok)
    end

    it 'assigns @shelves' do
      expect(assigns(:shelves)).to match_array shelves
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

    it 'assigns new @shelf' do
      expect(assigns(:shelf)).to be_a_new Shelf
    end

    it 'renders the :new template' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    let(:shelf_attributes) { attributes_for(:shelf) }

    it 'saves new shelf' do
      expect do
        post :create, params: { shelf: shelf_attributes }
      end.to change(Shelf, :count).by(1)
    end

    it 'redirects the :create template' do
      post :create, params: { shelf: shelf_attributes }
      expect(response).to redirect_to(shelves_path)
    end
  end

  describe 'GET #edit' do
    let(:shelf) { create(:shelf) }
    before { get :edit, params: { id: shelf.id } }

    it 'has a 200 status code' do
      expect(response).to have_http_status(:ok)
    end

    it 'assigns @shelf' do
      expect(assigns(:shelf)).to eq shelf
    end

    it 'renders the :edit template' do
      expect(response).to render_template :edit
    end
  end

  describe 'PATCH #update' do
    let!(:shelf) { create(:shelf) }
    let(:update_attributes) do
      {
          name: '新しい棚名',
          row_count: 9,
          col_count: 8,
      }
    end

    it 'saves updated shelf' do
      expect do
        patch :update, params: { id: shelf.id, shelf: update_attributes }
      end.to change(Shelf, :count).by(0)
    end

    it 'updates updated shelf' do
      patch :update, params: { id: shelf.id, shelf: update_attributes }
      shelf.reload
      expect(shelf.name).to eq update_attributes[:name]
    end

    it 'redirects the :create template' do
      patch :update, params: { id: shelf.id, shelf: update_attributes }
      expect(response).to redirect_to(shelves_path)
    end
  end

  describe 'DELETE #destroy' do
    let!(:shelf) { create(:shelf) }
    it 'deletes the shelf' do
      expect do
        delete :destroy, params: { id: shelf.id }
      end.to change(Shelf, :count).by(-1)
    end

    it 'redirects the :create template' do
      delete :destroy, params: { id: shelf.id }
      expect(response).to redirect_to(shelves_path)
    end
  end
end
