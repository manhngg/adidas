require 'rails_helper'
RSpec.describe ShelfInventory, type: :model do
  describe "Describe shelf_inventory" do
    context "column specifications" do
      it {is_expected.to have_db_column(:shelf_name).of_type(:string)}
      it {is_expected.to have_db_column(:staff_name).of_type(:string)}
      it {is_expected.to have_db_column(:device_number).of_type(:string)}
      it {is_expected.to have_db_column(:status).of_type(:integer)}
      it {is_expected.to have_db_column(:start_time).of_type(:datetime)}
      it {is_expected.to have_db_column(:finish_time).of_type(:datetime)}
      it {is_expected.to have_db_column(:inventory_id).of_type(:integer)}
    end
  end

  context "validations" do
    it {is_expected.to validate_presence_of :shelf_name}
  end

  context "associations" do
    it {is_expected.to belong_to(:inventory)}
  end
end
