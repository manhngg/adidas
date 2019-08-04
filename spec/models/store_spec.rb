require 'rails_helper'

RSpec.describe Store, type: :model do
  describe "Describe store" do
    context "column specifications" do
      it {is_expected.to have_db_column(:name).of_type(:string)}
      it {is_expected.to have_db_column(:area_id).of_type(:integer)}
    end

    context "validations" do
      it {is_expected.to validate_presence_of :name}
    end

    context "associations" do
      it {is_expected.to belong_to(:area)}
      it {is_expected.to have_many(:shelves)}
      it {is_expected.to have_many(:inventories)}
      it {is_expected.to have_many(:admin_manage_stores)}
      it {is_expected.to have_many(:store_users)}
      it {is_expected.to have_many(:message_groups)}
      it {is_expected.to have_many(:transceiver_groups)}
      it {is_expected.to have_many(:devices)}
      it {is_expected.to have_many(:adrsbooks)}
      it {is_expected.to have_many(:api_keys)}
      it {is_expected.to have_many(:orders)}
      it {is_expected.to have_many(:stocks)}
      it {is_expected.to have_many(:record_reports)}
    end
  end
end
