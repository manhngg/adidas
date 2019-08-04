require 'ffaker'

FactoryBot.define do
  factory :shelf_inventory do
    shelf_name {"shelf 1"}
    staff_name {FFaker::Name.name}
    device_number {rand(100...1000)}
    status {FFaker::Name.name}
    start_time {FFaker::Time.between(30.days.ago, Date.today)}
    finish_time {FFaker::Time.between(30.days.ago, Date.today)}
    association :inventory
  end
end
