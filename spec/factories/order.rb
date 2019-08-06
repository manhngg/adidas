require 'ffaker'

FactoryBot.define do
  factory :order do
    order_date {FFaker::Time.between(2.days.ago, Date.today)}
    order_number {rand(10...100)}
    association :store
    association :supplier
  end
end
