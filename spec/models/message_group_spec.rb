require 'rails_helper'

RSpec.describe MessageGroup, type: :model do
  describe "Describe message_group" do
    context "column specifications" do
      it {is_expected.to have_db_column(:name).of_type(:string)}
      it {is_expected.to have_db_column(:store_id).of_type(:integer)}
    end

    context "validations" do
      it {is_expected.to validate_presence_of :name}
    end

    context "associations" do
      it {is_expected.to belong_to(:store)}
      it {is_expected.to have_many(:messages)}
    end
  end
end
