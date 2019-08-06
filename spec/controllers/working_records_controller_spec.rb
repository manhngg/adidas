require 'rails_helper'

RSpec.describe WorkingRecordsController, type: :controller do
  describe 'GET #index' do
    let(:working_records) { create_list(:working_record, 1) }
    before { get :index }

    it 'has a 200 status code' do
      expect(response).to have_http_status(:ok)
    end

    it 'assigns @working_records' do
      expect(assigns(:working_records)).to match_array working_records
    end

    it 'renders the :index template' do
      expect(response).to render_template :index
    end
  end
end
