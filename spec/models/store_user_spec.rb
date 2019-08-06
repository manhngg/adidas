# == Schema Information
#
# Table name: store_users
#
#  id         :bigint           not null, primary key
#  store_id   :bigint
#  user_id    :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe StoreUser, type: :model do
  describe "Describe store_user" do
    context "column specifications" do
      it {is_expected.to have_db_column(:store_id).of_type(:integer)}
      it {is_expected.to have_db_column(:user_id).of_type(:integer)}
    end

    context "associations" do
      it {is_expected.to belong_to(:store)}
      it {is_expected.to belong_to(:user)}
    end
  end
end
