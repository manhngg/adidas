FactoryBot.define do
	factory :message_group do
		association :store
		name { "キッチン" }
	end
end
