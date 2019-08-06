require 'rails_helper'
RSpec.describe ProductInventory, type: :model do
  describe "Describe product_inventory" do
    context "column specifications" do
      it {is_expected.to have_db_column(:product_name).of_type(:string)}
      it {is_expected.to have_db_column(:jan_code).of_type(:string)}
      it {is_expected.to have_db_column(:stock_count).of_type(:integer)}
      it {is_expected.to have_db_column(:inventory_count).of_type(:integer)}
      it {is_expected.to have_db_column(:unmatched_flag).of_type(:integer)}
      it {is_expected.to have_db_column(:inventory_time).of_type(:datetime)}
      it {is_expected.to have_db_column(:diff_number).of_type(:string)}
      it {is_expected.to have_db_column(:inventory_id).of_type(:integer)}
    end
  end

  context "validations" do
    it {is_expected.to validate_presence_of :product_name}
    it {is_expected.to validate_presence_of :jan_code}
    it {is_expected.to validate_uniqueness_of(:jan_code).case_insensitive}
    it {is_expected.to validate_numericality_of(:jan_code).only_integer}
    it {is_expected.to validate_length_of(:jan_code).is_at_most(13)}
  end

  context "associations" do
    it {is_expected.to belong_to(:inventory)}
    it {is_expected.to have_many(:shelf_stock_inventories)}
  end
end
