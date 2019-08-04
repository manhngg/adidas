# == Schema Information
#
# Table name: devices
#
#  id                   :bigint           not null, primary key
#  number               :string(255)
#  name                 :string(255)
#  encrypted_password   :string(255)
#  registered           :boolean          default("no")
#  store_id             :bigint
#  transceiver_group_id :bigint
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

FactoryBot.define do
	factory :device do
		association :store
		sequence(:name)       	{ |n| "device#{n}" }
		encrypted_password  		{ "12345678" }
	end
end
