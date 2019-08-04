require 'ffaker'

FactoryBot.define do
  factory :shelf_stock_inventory do
    shelf_name {FFaker::Name.name}
    row {rand(1...1000)}
    col {rand(1...1000)}
    inventory_count {rand(1...1000)}
    inventory_time {FFaker::Time.between(30.days.ago, Date.today)}
    staff_name {FFaker::Name.name}
    device_number {rand(1...1000)}
    error_type {rand(1...9)}
    association :inventory
    association :product_inventory
  end
end
