require 'rails_helper'

RSpec.describe RecordReportsController, type: :controller do
  describe 'GET #index' do
    let(:record_reports) { create_list(:record_report, 3) }
    before { get :index }

    it 'has a 200 status code' do
      expect(response).to have_http_status(:ok)
    end

    it 'assigns @record_reports' do
      expect(assigns(:record_reports)).to match_array record_reports
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

    it 'assigns new @record_report' do
      expect(assigns(:record_report)).to be_a_new RecordReport
    end

    it 'renders the :new template' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    let(:record_report_attributes) { attributes_for(:record_report) }

    it 'saves new record_report' do
      expect do
        post :create, params: { record_report: record_report_attributes }
      end.to change(RecordReport, :count).by(1)
    end

    it 'redirects the :create template' do
      post :create, params: { record_report: record_report_attributes }
      expect(response).to redirect_to(record_reports_path)
    end
  end

  describe 'GET #edit' do
    let(:record_report) { create(:record_report) }
    before { get :edit, params: { id: record_report.id } }

    it 'has a 200 status code' do
      expect(response).to have_http_status(:ok)
    end

    it 'assigns @record_report' do
      expect(assigns(:record_report)).to eq record_report
    end

    it 'renders the :edit template' do
      expect(response).to render_template :edit
    end
  end

  describe 'PATCH #update' do
    let!(:record_report) { create(:record_report) }
    let(:update_attributes) do
      {
          record_date: '2019-06-30',
          start_time: "09:00",
          stop_time: "20:00",
          break_time: 2
      }
    end

    it 'saves updated record_report' do
      expect do
        patch :update, params: { id: record_report.id, record_report: update_attributes }
      end.to change(RecordReport, :count).by(0)
    end

    it 'updates updated record_report' do
      patch :update, params: { id: record_report.id, record_report: update_attributes }
      record_report.reload
      expect(record_report.record_date).to eq update_attributes[:record_date]
      expect(record_report.start_time).to eq update_attributes[:start_time]
      expect(record_report.stop_time).to eq update_attributes[:stop_time]
      expect(record_report.break_time).to eq update_attributes[:break_time]
    end

    it 'redirects the :create template' do
      patch :update, params: { id: record_report.id, record_report: update_attributes }
      expect(response).to redirect_to(record_reports_path)
    end
  end

  describe 'DELETE #destroy' do
    let!(:record_report) { create(:record_report) }
    it 'deletes the record_report' do
      expect do
        delete :destroy, params: { id: record_report.id }
      end.to change(RecordReport, :count).by(-1)
    end

    it 'redirects the :create template' do
      delete :destroy, params: { id: record_report.id }
      expect(response).to redirect_to(record_reports_path)
    end
  end
end
