class Api::V1::WorkingRecordsController < Api::V1::ApiController
  before_action :authorize_request
  before_action :find_user, :find_record_action, only: :create

	# POST /api/v1/timesheets
  def create
    ActiveRecord::Base.transaction do
      create_working_record
    end
  rescue Exception => e
    render json: {errors: e}
  end

  private

  attr_reader :working_record, :user, :record_action, :record_report

  def create_working_record
    @working_record = WorkingRecord.new action_time: Time.zone.now,
      user_id: user.id, record_action_id: record_action.id
    if working_record.save!
      create_or_update_record_report
      render json: {
        name: user.full_name,
        message: "#{record_action.name}時刻の登録が完了しました",
				time: working_record.action_time.strftime("%Y-%m-%d %H:%M:%S")}, status: 200
    else
      render json: {errors: working_record.errors.full_messages}, status: 422
    end
  end

  def create_or_update_record_report
    @record_report = user.record_reports.find_by record_date: Time.zone.now.beginning_of_day,
      store_id: params[:store_id]
    if record_report
      update_record_report
    else
      create_record_report
    end
  end

  def create_record_report
    #出勤
    if working_record.record_action_id == 1
      create_record_report_with_params start_time: Time.zone.now
    end

    #休憩入り
    if working_record.record_action_id == 2
      create_record_report_with_params
    end

    #休憩戻り
    if working_record.record_action_id == 3
      WorkingRecord.find_by("action_time >= ? AND action_time < ? AND user_id = ? AND record_action_id = ?",
        Time.zone.now.beginning_of_day, Time.zone.now.beginning_of_day + 1.days, 1, 2)
      return unless working_record_previous
      create_record_report_with_params break_time:
        (Time.zone.now - working_record_previous.action_time).to_i
    end

    #退勤
    if working_record.record_action_id == 4
      create_record_report_with_params stop_time: Time.zone.now
    end
  end

  def create_record_report_with_params args = {}
    @record_report = user.record_reports.create! record_date: Time.zone.now.beginning_of_day,
      start_time: args[:start_time], stop_time: args[:stop_time],
      break_time: args[:break_time], store_id: params[:store_id]
  end

  def update_record_report
    #出勤
    if working_record.record_action_id == 1
      user.record_reports.update start_time: Time.zone.now, store_id: params[:store_id]
    end

    #休憩入り
    if working_record.record_action_id == 2
      user.record_reports.update store_id: params[:store_id]
    end

    #休憩戻り
    if working_record.record_action_id == 3
      working_record_previous = WorkingRecord.find_by("DATE(action_time) = ?
        AND user_id = ? AND record_action_id = ?", Date.today, user.id, 2)
      return unless working_record_previous
      user.record_reports.update store_id: params[:store_id], break_time:
        (Time.zone.now - working_record_previous.action_time).to_i
    end

    #退勤
    if working_record.record_action_id == 4 #退勤
      user.record_reports.update stop_time: Time.zone.now, store_id: params[:store_id]
    end
  end

  def find_user
    @user = User.find_by staff_id: params[:staff_id]
    render json: {message: "ユーザーが見つかりません"}, status: 404 unless user
  end

  def find_record_action
    @record_action = RecordAction.find_by id: params[:action_type].to_i + 1
    return if record_action
    render json: {message: "レコードアクションが見つかりません"}, status: 404
  end
end
