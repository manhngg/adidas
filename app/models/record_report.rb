class RecordReport < ApplicationRecord
  belongs_to :user
  belongs_to :store

  validates :record_date, presence: true, numericality: {less_than_or_equal_to: 9999999}

  def self.to_csv(header: csv_column_names, row_sep: "\r\n", encoding: Encoding::CP932)
    records = CSV.generate(row_sep: row_sep) do |csv|
      csv << header
      all.each do |record|
        csv << record.csv_column_values
      end
    end
    records.encode(encoding, invalid: :replace, undef: :replace)
  end

  def self.csv_column_names
    ["店舗", "ユーザーID ", "名前", "日付", "出勤時刻", "退勤時刻", "休憩時間", ""]
  end

  def csv_column_values
    [store.name, user.staff_id, user.full_name, record_date, start_time, stop_time, break_time, edit_flag]
  end
end
