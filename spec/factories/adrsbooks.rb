FactoryBot.define do
  factory :adrsbook do
    association :adrsbook_subcategory
    association :store
    name {"ペット売場グループ"}
    furigana {"連絡先名ふりがな"}
    tel1 {"0906544532"}
    tel2 {"0906544533"}
    tel3 {"0906544534"}
    category {"店内"}
  end
end
