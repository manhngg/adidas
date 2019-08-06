FactoryBot.define do
  # TODO: Create more records
  factory :working_record do
    association :store
    association :user
    association :record_action
    action_time { Time.now }
  end
end
