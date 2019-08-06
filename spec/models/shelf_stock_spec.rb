# == Schema Information
#
# Table name: shelf_stocks
#
#  id         :bigint           not null, primary key
#  row        :integer
#  column     :integer
#  shelf_id   :bigint
#  stock_id   :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe ShelfStock, type: :model do
  context "column specifications" do
    it {is_expected.to have_db_column(:row).of_type(:integer)}
    it {is_expected.to have_db_column(:column).of_type(:integer)}
    it {is_expected.to have_db_column(:shelf_id).of_type(:integer)}
    it {is_expected.to have_db_column(:stock_id).of_type(:integer)}
  end

  context "associations" do
    it {is_expected.to belong_to(:shelf)}
    it {is_expected.to belong_to(:stock)}
  end
end
