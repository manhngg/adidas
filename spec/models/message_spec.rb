require 'rails_helper'

RSpec.describe Message, type: :model do
  describe "Describe message" do
    context "column specifications" do
      it {is_expected.to have_db_column(:submit_user_name).of_type(:string)}
      it {is_expected.to have_db_column(:msg_text).of_type(:string)}
      it {is_expected.to have_db_column(:message_group_id).of_type(:integer)}
    end

    context "validations" do
      it {is_expected.to validate_presence_of :submit_user_name}
      it {is_expected.to validate_presence_of :msg_text}
    end

    context "associations" do
      it {is_expected.to belong_to(:message_group)}
    end
  end
end
