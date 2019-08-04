require 'rails_helper'

RSpec.describe Order, type: :model do
  context "column specifications" do
    it {is_expected.to have_db_column(:order_date).of_type(:datetime)}
    it {is_expected.to have_db_column(:order_number).of_type(:string)}
    it {is_expected.to have_db_column(:supplier_id).of_type(:integer)}
    it {is_expected.to have_db_column(:store_id).of_type(:integer)}
  end

  context "associations" do
    it {is_expected.to belong_to(:supplier)}
    it {is_expected.to belong_to(:store)}
    it {is_expected.to have_many(:order_items)}
  end

  context "validates" do
    it {is_expected.to validate_presence_of :order_number}
    it {is_expected.to validate_numericality_of(:order_number).only_integer}
  end
end
