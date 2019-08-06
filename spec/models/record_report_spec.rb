require 'rails_helper'

RSpec.describe RecordReport, type: :model do
  describe "Describe record_report" do
    context "column specifications" do
      it {is_expected.to have_db_column(:record_date).of_type(:datetime)}
      it {is_expected.to have_db_column(:start_time).of_type(:datetime)}
      it {is_expected.to have_db_column(:stop_time).of_type(:datetime)}
      it {is_expected.to have_db_column(:break_time).of_type(:integer)}
      it {is_expected.to have_db_column(:user_id).of_type(:integer)}
      it {is_expected.to have_db_column(:store_id).of_type(:integer)}
    end

    context "validations" do
      it {is_expected.to validate_presence_of :record_date}
    end

    context "associations" do
      it {is_expected.to belong_to(:user)}
      it {is_expected.to belong_to(:store)}
    end
  end
end
