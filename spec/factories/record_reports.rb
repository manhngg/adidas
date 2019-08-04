FactoryBot.define do
  # TODO: Create more records
  factory :record_report do
    association :store
    association :user
    record_date { "2019-06-20" }
    start_time { "10:00" }
    stop_time { "19:00" }
    break_time { "1:00" }
  end
end