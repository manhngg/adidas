# == Schema Information
#
# Table name: areas
#
#  id            :bigint           not null, primary key
#  name          :string(255)
#  order         :integer
#  prefecture_id :bigint
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

FactoryBot.define do
	factory :area do
		association :region
		association :prefecture
		name { "渋谷" }
	end
end
