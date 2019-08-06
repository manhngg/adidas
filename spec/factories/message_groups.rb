# == Schema Information
#
# Table name: message_groups
#
#  id         :bigint           not null, primary key
#  name       :string(255)
#  store_id   :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
	factory :message_group do
		association :store
		name { "キッチン" }
	end
end
