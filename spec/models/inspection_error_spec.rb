require 'rails_helper'

RSpec.describe InspectionError, type: :model do
  describe "Describe inspection_error" do
    context "column specifications" do
      it {is_expected.to have_db_column(:inspection_date).of_type(:datetime)}
      it {is_expected.to have_db_column(:inspection_count).of_type(:integer)}
      it {is_expected.to have_db_column(:jan_code).of_type(:string)}
      it {is_expected.to have_db_column(:error_type).of_type(:integer)}
    end

    context "associations" do
      it {is_expected.to belong_to(:store)}
    end
  end
end
