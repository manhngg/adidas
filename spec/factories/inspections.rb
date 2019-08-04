FactoryBot.define do
	factory :inspection do
		association :order_item
		last_inspection  			{ "2019-06-20" }
		inspection_count  		{ 260 }
	end
end
