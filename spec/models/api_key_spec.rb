# == Schema Information
#
# Table name: api_keys
#
#  id         :bigint           not null, primary key
#  key_name   :string(255)
#  key_value  :string(255)
#  store_id   :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe ApiKey, type: :model do
  describe "Describe api_key" do
    context "column specifications" do
      it {is_expected.to have_db_column(:key_name).of_type(:string)}
      it {is_expected.to have_db_column(:key_value).of_type(:string)}
    end
  end

  context "validations" do
    it {is_expected.to validate_presence_of :key_name}
    it {is_expected.to validate_presence_of :key_value}
  end

  context "associations" do
    it {is_expected.to belong_to(:store)}
  end
end
