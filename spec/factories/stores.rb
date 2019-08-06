# == Schema Information
#
# Table name: stores
#
#  id         :bigint           not null, primary key
#  name       :string(255)
#  area_id    :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
	factory :store do
		association :region
		association :prefecture
		association :area
		name { "渋谷店" }
	end
end
