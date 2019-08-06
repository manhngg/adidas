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

require 'rails_helper'

RSpec.describe Product, type: :model do
  context "column specifications" do
    it {is_expected.to have_db_column(:name).of_type(:string)}
    it {is_expected.to have_db_column(:jan_code).of_type(:string)}
  end

  context "validates" do
    it {is_expected.to validate_presence_of :name}
    it {is_expected.to validate_presence_of :jan_code}
    it {is_expected.to validate_uniqueness_of(:jan_code).case_insensitive}
    it {is_expected.to validate_length_of(:jan_code).is_at_most(13)}
  end
end
