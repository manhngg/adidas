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

require 'rails_helper'

RSpec.describe Company, type: :model do
  context "column specifications" do
    it {is_expected.to have_db_column(:name).of_type(:string)}
    it {is_expected.to have_db_column(:subdomain).of_type(:string)}
  end

  context "validates" do
    it {is_expected.to validate_presence_of :name}
    it {is_expected.to validate_presence_of :subdomain}
  end
end
