FactoryBot.define do
  factory :stock do
    association :product
    association :store
    stock_count { rand(1...1000) }
    price { rand(100...10000) }
  end
end
