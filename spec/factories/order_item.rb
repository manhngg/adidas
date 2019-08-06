require 'ffaker'

FactoryBot.define do
  factory :order_item do
    order_count {rand(10...100)}
    delivery_date {FFaker::Time.between(20.days.ago, Date.today)}
    association :order
    association :product
    association :supplier
  end
end
