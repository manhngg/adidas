require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  context "column specifications" do
    it {is_expected.to have_db_column(:order_count).of_type(:integer)}
    it {is_expected.to have_db_column(:delivery_date).of_type(:datetime)}
    it {is_expected.to have_db_column(:product_id).of_type(:integer)}
    it {is_expected.to have_db_column(:order_id).of_type(:integer)}
  end

  context "associations" do
    it {is_expected.to belong_to(:order)}
    it {is_expected.to belong_to(:product)}
  end

  context "validates" do
    it {is_expected.to validate_numericality_of(:order_count).only_integer}
  end
end
