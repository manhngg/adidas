# == Schema Information
#
# Table name: working_records
#
#  id               :bigint           not null, primary key
#  action_time      :datetime
#  user_id          :bigint
#  record_action_id :bigint
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'rails_helper'

RSpec.describe WorkingRecord, type: :model do
  describe "Describe working_records" do
    context "column specifications" do
      it {is_expected.to have_db_column(:action_time).of_type(:datetime)}
      it {is_expected.to have_db_column(:user_id).of_type(:integer)}
      it {is_expected.to have_db_column(:record_action_id).of_type(:integer)}
    end

    context "associations" do
      it {is_expected.to belong_to(:record_action)}
      it {is_expected.to belong_to(:user)}
    end
  end
end
