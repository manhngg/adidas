# == Schema Information
#
# Table name: shelves
#
#  id         :bigint           not null, primary key
#  name       :string(255)
#  row_count  :integer
#  col_count  :integer
#  store_id   :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Shelf, type: :model do
  describe "Describe shelf" do
    context "column specifications" do
      it {is_expected.to have_db_column(:name).of_type(:string)}
      it {is_expected.to have_db_column(:row_count).of_type(:integer)}
      it {is_expected.to have_db_column(:col_count).of_type(:integer)}
    end

    context "validations" do
      it {is_expected.to validate_presence_of :name}
      it {should validate_numericality_of(:row_count).only_integer}
      it {should validate_numericality_of(:col_count).only_integer}
    end

    context "associations" do
      it {is_expected.to belong_to(:store)}
      it {is_expected.to have_many(:shelf_stocks)}
    end
  end
end
