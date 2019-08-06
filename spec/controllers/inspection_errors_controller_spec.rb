require 'rails_helper'

RSpec.describe InspectionErrorsController, type: :controller do
  describe 'GET #index' do
    let(:inspection_errors) { create_list(:inspection_error, 3) }
    before { get :index }

    it 'has a 200 status code' do
      expect(response).to have_http_status(:ok)
    end

    it 'assigns @inspection_errors' do
      expect(assigns(:inspection_errors)).to match_array inspection_errors
    end

    it 'renders the :index template' do
      expect(response).to render_template :index
    end
  end
end
