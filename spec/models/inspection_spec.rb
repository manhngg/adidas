require 'rails_helper'

RSpec.describe Inspection, type: :model do
  describe "Describe inspection" do
    context "column specifications" do
      it {is_expected.to have_db_column(:inspection_count).of_type(:integer)}
      it {is_expected.to have_db_column(:device_number).of_type(:string)}
      it {is_expected.to have_db_column(:staff_name).of_type(:string)}
      it {is_expected.to have_db_column(:order_item_id).of_type(:integer)}
    end

    context "validations" do
      it {is_expected.to validate_presence_of :staff_name}
      it {is_expected.to validate_presence_of :device_number}
      it {should validate_numericality_of(:inspection_count).only_integer}
    end

    context "associations" do
      it {is_expected.to belong_to(:order_item)}
    end
  end
end
