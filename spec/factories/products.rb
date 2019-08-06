# == Schema Information
#
# Table name: products
#
#  id         :bigint           not null, primary key
#  name       :string(255)
#  jan_code   :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
	factory :product do
		sequence(:name)       	{ |n| "商品#{n}" }
		sequence(:jan_code)     { |n| "#{5326874569100 + n}" }
	end
end
