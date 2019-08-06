class InspectionErrorsController < BaseController
  def index
    # TODO: Set store
    @inspection_errors = InspectionError.all
                                        .order(inspection_date: :asc)
                                        .page(params[:page]).per(100)
    respond_to do |format|
      format.html
      format.csv do
        send_data render_to_string, filename: "仕入検品エラーリスト#{Time.current.strftime('%Y%m%d')}.csv", type: :csv
      end
    end
  end
end
