require 'ffaker'

FactoryBot.define do
  factory :inspection do
    inspection_count {rand(1...50)}
    staff_name {FFaker::Name.name }
    device_number {rand(100...1000)}
    last_inspection {Time.now}
    association :order_item
    association :order
  end
end
