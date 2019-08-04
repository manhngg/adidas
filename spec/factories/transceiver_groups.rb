FactoryBot.define do
	factory :transceiver_group do
		association :store
		name { "キッチン" }
		sip_id { "1111" }
	end
end
