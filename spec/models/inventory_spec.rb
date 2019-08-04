require 'rails_helper'

RSpec.describe Inventory, type: :model do
  describe "Describe inventory" do
    context "column specifications" do
      it {is_expected.to have_db_column(:start_time).of_type(:datetime)}
      it {is_expected.to have_db_column(:finish_time).of_type(:datetime)}
      it {is_expected.to have_db_column(:status).of_type(:integer)}
      it {is_expected.to have_db_column(:store_id).of_type(:integer)}
    end

    context "associations" do
      it {is_expected.to belong_to(:store)}
      it {is_expected.to have_many(:shelf_inventories)}
      it {is_expected.to have_many(:product_inventories)}
      it {is_expected.to have_many(:shelf_stock_inventories)}
    end
  end
end
