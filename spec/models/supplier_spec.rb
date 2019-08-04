require 'rails_helper'

RSpec.describe Supplier, type: :model do
  context "column specifications" do
    it {is_expected.to have_db_column(:name).of_type(:string)}
    it {is_expected.to have_db_column(:supplier_number).of_type(:string)}
  end

  context "associations" do
    it {is_expected.to have_many(:orders)}
  end

  context "validates" do
    it {is_expected.to validate_presence_of :name}
    it {is_expected.to validate_presence_of :supplier_number}
    it {is_expected.to validate_numericality_of(:supplier_number).only_integer}
    it {is_expected.to validate_length_of(:supplier_number).is_at_most(20)}
  end
end
