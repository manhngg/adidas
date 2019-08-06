# == Schema Information
#
# Table name: messages
#
#  id               :bigint           not null, primary key
#  submit_user_name :string(255)
#  msg_text         :string(255)
#  message_group_id :bigint
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

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
