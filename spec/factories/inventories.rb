require 'ffaker'

FactoryBot.define do
  factory :inventory do
    start_time {FFaker::Time.between(30.days.ago, Date.today)}
    finish_time {FFaker::Time.between(10.days.ago, Date.today)}
    status {"未実施"}
    association :store
  end
end
