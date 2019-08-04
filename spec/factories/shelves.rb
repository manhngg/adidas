require 'ffaker'

FactoryBot.define do
  factory :shelf do
    name {FFaker::Name.name}
    row_count {rand(1...100)}
    col_count {rand(1...100)}
    association :store
  end
end
