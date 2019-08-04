FactoryBot.define do
  factory :device do
    number {"0"}
    name {"渋谷"}
    encrypted_password {"12345678"}
    transceiver_group
  end
end
