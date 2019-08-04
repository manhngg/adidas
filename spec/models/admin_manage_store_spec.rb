require 'rails_helper'

RSpec.describe AdminManageStore, type: :model do
  describe "Describe admin_manage_store" do
    context "column specifications" do
      it {is_expected.to have_db_column(:store_id).of_type(:integer)}
      it {is_expected.to have_db_column(:admin_id).of_type(:integer)}
      it {is_expected.to have_db_column(:role).of_type(:string)}
    end

    context "validations" do
      it {should validate_numericality_of(:role).only_integer}
    end

    context "associations" do
      it {is_expected.to belong_to(:store)}
      it {is_expected.to belong_to(:admin)}
    end
  end
end
