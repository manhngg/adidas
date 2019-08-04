require 'rails_helper'

RSpec.describe Region, type: :model do
  describe "Describe region" do
    context "column specifications" do
      it {is_expected.to have_db_column(:name).of_type(:string)}
      it {is_expected.to have_db_column(:order).of_type(:integer)}
    end

    context "validations" do
      it {is_expected.to validate_presence_of :name}
    end

    context "associations" do
      it {is_expected.to have_many(:prefectures)}
    end
  end
end
