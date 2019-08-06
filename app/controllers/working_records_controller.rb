class WorkingRecordsController < BaseController
  def index
    @q = WorkingRecord.search
    if params[:q].present?
      @q = WorkingRecord.search(params[:q])
      @working_records = @q.result
                           .includes(:user).order("users.staff_id asc")
                           .order(action_time: :asc)
                           .page(params[:page]).per(100)
    else
      # TODO: Set store
      # TODO: Set order for store after set store
      @working_records = WorkingRecord.all
                                      .includes(:user).order("users.staff_id asc")
                                      .order(action_time: :asc)
                                      .page(params[:page]).per(100)
    end
  end
end
