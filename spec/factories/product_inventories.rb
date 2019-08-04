require 'ffaker'

FactoryBot.define do
  factory :product_inventory do
    product_name {FFaker::Name.name}
    jan_code {rand(1000...9999)}
    stock_count {rand(100...1000)}
    inventory_count {rand(100...1000)}
    unmatched_flag {rand(1..9)}
    inventory_time {FFaker::Time.between(1.days.ago, Date.today)}
    diff_number {rand(1..50)}
    association :inventory
  end
end
