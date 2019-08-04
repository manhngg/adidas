require 'rails_helper'

RSpec.describe TransceiverGroupsController, type: :controller do
  describe 'GET #edit' do
    let(:transceiver_group) { create(:transceiver_group) }
    before { get :edit, params: { id: transceiver_group.id } }

    it 'has a 200 status code' do
      expect(response).to have_http_status(:ok)
    end

    it 'assigns @transceiver_group' do
      expect(assigns(:transceiver_group)).to eq transceiver_group
    end

    it 'renders the :edit template' do
      expect(response).to render_template :edit
    end
  end

  describe 'PATCH #update' do
    let!(:transceiver_group) { create(:transceiver_group) }
    let(:update_attributes) do
      {
          name: '新しいトランシーバグループ名',
      }
    end

    it 'saves updated transceiver_group' do
      expect do
        patch :update, params: { id: transceiver_group.id, transceiver_group: update_attributes }
      end.to change(TransceiverGroup, :count).by(0)
    end

    it 'updates updated transceiver_group' do
      patch :update, params: { id: transceiver_group.id, transceiver_group: update_attributes }
      transceiver_group.reload
      expect(transceiver_group.name).to eq update_attributes[:name]
    end

    it 'redirects the :create template' do
      patch :update, params: { id: transceiver_group.id, transceiver_group: update_attributes }
      expect(response).to redirect_to(groups_path)
    end
  end

  describe 'DELETE #destroy' do
    let!(:transceiver_group) { create(:transceiver_group) }
    it 'deletes the transceiver_group' do
      expect do
        delete :destroy, params: { id: transceiver_group.id }
      end.to change(TransceiverGroup, :count).by(-1)
    end

    it 'redirects the Group :index template' do
      delete :destroy, params: { id: transceiver_group.id }
      expect(response).to redirect_to(groups_path)
    end
  end
end
