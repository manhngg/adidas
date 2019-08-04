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
