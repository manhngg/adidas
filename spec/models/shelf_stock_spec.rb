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
