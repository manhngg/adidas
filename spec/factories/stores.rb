FactoryBot.define do
	factory :store do
		association :area
		name { "渋谷店" }
	end
end
