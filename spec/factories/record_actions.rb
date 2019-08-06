FactoryBot.define do
  factory :record_action do
    name { "CheckIn" }
    order { Time.zone.now.to_i }
  end
end
