require 'rails_helper'

RSpec.describe ShelfStockInventory, type: :model do
  describe "Describe shelf_inventory" do
    context "column specifications" do
      it {is_expected.to have_db_column(:shelf_name).of_type(:string)}
      it {is_expected.to have_db_column(:row).of_type(:integer)}
      it {is_expected.to have_db_column(:col).of_type(:integer)}
      it {is_expected.to have_db_column(:inventory_count).of_type(:integer)}
      it {is_expected.to have_db_column(:inventory_time).of_type(:datetime)}
      it {is_expected.to have_db_column(:staff_name).of_type(:string)}
      it {is_expected.to have_db_column(:device_number).of_type(:string)}
      it {is_expected.to have_db_column(:device_number).of_type(:string)}
      it {is_expected.to have_db_column(:inventory_id).of_type(:integer)}
      it {is_expected.to have_db_column(:product_inventory_id).of_type(:integer)}
    end
  end

  context "validations" do
  end

  context "associations" do
    it {is_expected.to belong_to(:inventory)}
    it {is_expected.to belong_to(:product_inventory)}
  end
end
