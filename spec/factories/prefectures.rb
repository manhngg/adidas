FactoryBot.define do
	factory :prefecture do
		association :region
		name { "東京都" }
	end
end
