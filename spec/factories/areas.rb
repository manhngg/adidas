FactoryBot.define do
	factory :area do
		association :prefecture
		name { "渋谷" }
	end
end
