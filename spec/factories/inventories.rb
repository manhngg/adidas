require 'ffaker'

FactoryBot.define do
  factory :inventory do
    start_time {FFaker::Time.between(30.days.ago, Date.today)}
    association :store
  end
end
