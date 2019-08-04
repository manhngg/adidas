require 'rails_helper'

RSpec.describe AdrsbookSubcategory, type: :model do
  context "column specifications" do
    it {is_expected.to have_db_column(:name).of_type(:string)}
    it {is_expected.to have_db_column(:order).of_type(:integer)}
  end

  context "associations" do
    it {is_expected.to have_many(:adrsbooks)}
  end

  context "validates" do
    it {is_expected.to validate_presence_of :name}
    it {is_expected.to validate_numericality_of(:order).only_integer}
  end
end
