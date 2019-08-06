require 'csv'

CSV.generate(encoding: Encoding::SJIS, row_sep: "\r\n", force_quotes: true) do |csv|
  csv_column_names = %w(日付 個数 JANコード エラー種別)
  csv << csv_column_names
  @inspection_errors.each do |inspection_error|
    csv_column_values = [
      inspection_error.inspection_date,
      inspection_error.inspection_count,
      inspection_error.jan_code,
      inspection_error.error_type
    ]
    csv << csv_column_values
  end
end
