FactoryBot.define do
  factory :product do
    name { FFaker::JobJA.title }
    jan_code { rand(1000...99999) }
  end
end
