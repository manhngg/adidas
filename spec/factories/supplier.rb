require 'ffaker'

FactoryBot.define do
  factory :supplier do
    name {FFaker::Name.name}
    supplier_number {rand(1000...9999)}
  end
end
