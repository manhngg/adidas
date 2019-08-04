require 'rails_helper'

RSpec.describe Stock, type: :model do
  context "column specifications" do
    it {is_expected.to have_db_column(:stock_count).of_type(:integer)}
    it {is_expected.to have_db_column(:price).of_type(:integer)}
    it {is_expected.to have_db_column(:store_id).of_type(:integer)}
    it {is_expected.to have_db_column(:product_id).of_type(:integer)}
  end

  context "associations" do
    it {is_expected.to belong_to(:store)}
    it {is_expected.to belong_to(:product)}
  end

  context "validates" do
    it {is_expected.to validate_numericality_of(:stock_count).only_integer}
    it {is_expected.to validate_numericality_of(:price).only_integer}
  end
end
