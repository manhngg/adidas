FactoryBot.define do
  factory :user do
    full_name { FFaker::NameJA.name }
    full_name_furigana {  FFaker::NameJA.name }
    first_name {  FFaker::NameJA.name }
    first_name_furigana {  FFaker::NameJA.name }
    last_name {  FFaker::NameJA.name }
    last_name_furigana {  FFaker::NameJA.name }
    staff_id { FFaker::Address.city }
    level { 1 }
    encrypted_password { BCrypt::Password.create("12345678") }
  end
end
