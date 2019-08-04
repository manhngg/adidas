require 'rails_helper'

RSpec.describe TransceiverGroup, type: :model do
  describe "Describe transceiver_group" do
    context "column specifications" do
      it {is_expected.to have_db_column(:name).of_type(:string)}
      it {is_expected.to have_db_column(:store_id).of_type(:integer)}
      it {is_expected.to have_db_column(:sip_id).of_type(:string)}
    end

    context "validations" do
      it {is_expected.to validate_presence_of :name}
      it {is_expected.to validate_presence_of :sip_id}
    end

    context "associations" do
      it {is_expected.to belong_to(:store)}
      it {is_expected.to have_many(:devices)}
    end
  end
end
