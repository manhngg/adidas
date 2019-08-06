# == Schema Information
#
# Table name: companies
#
#  id         :bigint           not null, primary key
#  name       :string(255)
#  subdomain  :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Company < ApplicationRecord
  validates :name, :subdomain, presence: true

	# Create tenant when create new company
	# after_create :create_tenant

	# Drop tenant when destroy company
	# after_destroy :drop_tenant

	private

		def create_tenant
			Apartment::Tenant.create(subdomain)
		end

		def drop_tenant
			Apartment::Tenant.drop(subdomain)
		end
end
