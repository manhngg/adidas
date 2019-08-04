require 'rails_helper'

RSpec.describe AdminManageUser, type: :model do
  describe "Describe admin_manage_user" do
    context "column specifications" do
      it {is_expected.to have_db_column(:admin_id).of_type(:integer)}
      it {is_expected.to have_db_column(:user_id).of_type(:integer)}
    end

    context "associations" do
      it {is_expected.to belong_to(:admin)}
      it {is_expected.to belong_to(:user)}
    end
  end
end
