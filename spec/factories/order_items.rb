FactoryBot.define do
	factory :order_item do
		association :supplier
		association :order
		delivery_date  			{ "2019-06-20" }
		order_count  			  { 260 }
	end
end
