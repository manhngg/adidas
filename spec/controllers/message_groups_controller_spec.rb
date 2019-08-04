require 'rails_helper'

RSpec.describe MessageGroupsController, type: :controller do
  describe 'GET #edit' do
    let(:message_group) { create(:message_group) }
    before { get :edit, params: { id: message_group.id } }

    it 'has a 200 status code' do
      expect(response).to have_http_status(:ok)
    end

    it 'assigns @message_group' do
      expect(assigns(:message_group)).to eq message_group
    end

    it 'renders the :edit template' do
      expect(response).to render_template :edit
    end
  end

  describe 'PATCH #update' do
    let!(:message_group) { create(:message_group) }
    let(:update_attributes) do
      {
          name: '新しいメッセージグループ名',
      }
    end

    it 'saves updated message_group' do
      expect do
        patch :update, params: { id: message_group.id, message_group: update_attributes }
      end.to change(MessageGroup, :count).by(0)
    end

    it 'updates updated message_group' do
      patch :update, params: { id: message_group.id, message_group: update_attributes }
      message_group.reload
      expect(message_group.name).to eq update_attributes[:name]
    end

    it 'redirects the :create template' do
      patch :update, params: { id: message_group.id, message_group: update_attributes }
      expect(response).to redirect_to(groups_path)
    end
  end

  describe 'DELETE #destroy' do
    let!(:message_group) { create(:message_group) }
    it 'deletes the message_group' do
      expect do
        delete :destroy, params: { id: message_group.id }
      end.to change(MessageGroup, :count).by(-1)
    end

    it 'redirects the Group :index template' do
      delete :destroy, params: { id: message_group.id }
      expect(response).to redirect_to(groups_path)
    end
  end
end
