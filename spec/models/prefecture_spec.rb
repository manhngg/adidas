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

require 'rails_helper'

RSpec.describe Prefecture, type: :model do
  describe "Describe email" do
    context "column specifications" do
      it {is_expected.to have_db_column(:name).of_type(:string)}
      it {is_expected.to have_db_column(:order).of_type(:integer)}
      it {is_expected.to have_db_column(:region_id).of_type(:integer)}
    end

    context "validations" do
      it {is_expected.to validate_presence_of :name}
    end

    context "associations" do
      it {is_expected.to belong_to(:region)}
      it {is_expected.to have_many(:areas)}
    end
  end
end
