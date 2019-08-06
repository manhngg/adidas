# == Schema Information
#
# Table name: prefectures
#
#  id         :bigint           not null, primary key
#  name       :string(255)
#  order      :integer
#  region_id  :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
	factory :prefecture do
		association :region
		name { "東京都" }
	end
end
