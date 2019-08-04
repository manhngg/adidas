require 'rails_helper'

RSpec.describe GroupsController, type: :controller do
  describe 'GET #index' do
    let(:message_groups) { create_list(:message_group, 3) }
    let(:transceiver_groups) { create_list(:transceiver_group, 3) }
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

    it 'renders the :new template' do
      expect(response).to render_template :new
    end
  end
end
