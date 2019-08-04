# == Schema Information
#
# Table name: transceiver_groups
#
#  id         :bigint           not null, primary key
#  sip_id     :string(255)
#  name       :string(255)
#  store_id   :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
	factory :transceiver_group do
		association :store
		name						  		 { "キッチン" }
		sip_id 				  	 	 	 { "2012340001000" }
		# sequence(:number)              { |n| "#{10000 + n}" }
	end
end
