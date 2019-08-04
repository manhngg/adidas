class RecordReportsController < ApplicationController
  before_action :set_record_report, only: [:edit, :update, :destroy]

  def index
    @q = @store.record_reports.search
    if params[:q].present?
      @q = @store.record_reports.search(params[:q])
      @record_reports = @q.result
                            .includes(:store).order("stores.id asc")
                            .includes(:user).order("users.staff_id asc")
                            .order(record_date: :asc)
                            .page(params[:page]).per(100)
    else
      # TODO: Set store
      @record_reports = @store.record_reports
                            .includes(:store).order("stores.id asc")
                            .includes(:user).order("users.staff_id asc")
                            .order(record_date: :asc)
                            .page(params[:page]).per(100)
    end

    if params[:export_csv]
      send_data @record_reports.to_csv, filename: "出退勤管理レポート#{Time.current.strftime('%Y%m%d')}.csv"
    else
      render :index
    end
  end

  def new
    @record_report = RecordReport.new
  end

  def edit
  end

  def create
    @record_report = RecordReport.new(record_report_params)

    # TODO: Set store and user

    respond_to do |format|
      if @record_report.save
        # TODO: Change to Japanese
        format.html { redirect_to record_reports_url(store_id: @store.id),
          notice: 'RecordReport was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @record_report.update(record_report_params)
        format.html { redirect_to record_reports_url(store_id: @store.id),
          notice: 'RecordReport was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @record_report.destroy
    respond_to do |format|
      format.html { redirect_to record_reports_url(store_id: @store.id),
        notice: 'RecordReport was successfully destroyed.' }
    end
  end

  private
    def set_record_report
      # TODO: set store after implemented menu and user management
      @record_report = RecordReport.find(params[:id])
    end

    def record_report_params
      params.require(:record_report).permit(:record_date, :start_time, :stop_time, :start_time,
        :break_time, :store_id, :user_id)
    end
end
