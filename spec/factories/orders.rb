FactoryBot.define do
	factory :order do
		association :store
		association :supplier
		order_number      { "23646455" }
		order_date  			{ "2019-06-20" }
		order_count  			{ 260 }
		inspection_count  { 220 }
	end
end
