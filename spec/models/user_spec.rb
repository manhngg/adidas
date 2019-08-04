require 'rails_helper'
RSpec.describe User, type: :model do
  describe "Describe user" do
    context "column specifications" do
      it {is_expected.to have_db_column(:full_name).of_type(:string)}
      it {is_expected.to have_db_column(:full_name_furigana).of_type(:string)}
      it {is_expected.to have_db_column(:first_name).of_type(:string)}
      it {is_expected.to have_db_column(:first_name_furigana).of_type(:string)}
      it {is_expected.to have_db_column(:last_name).of_type(:string)}
      it {is_expected.to have_db_column(:last_name_furigana).of_type(:string)}
      it {is_expected.to have_db_column(:staff_id).of_type(:string)}
      it {is_expected.to have_db_column(:level).of_type(:integer)}
      it {is_expected.to have_db_column(:encrypted_password).of_type(:string)}
      it {is_expected.to have_db_column(:reset_password_token).of_type(:string)}
      it {is_expected.to have_db_column(:reset_password_sent_at).of_type(:datetime)}
      it {is_expected.to have_db_column(:remember_created_at).of_type(:datetime)}
    end
  end

  context "validations" do
    it {is_expected.to validate_presence_of :first_name}
    it {is_expected.to validate_length_of(:first_name).is_at_most(10)}
    it {is_expected.to validate_length_of(:first_name).is_at_least(2)}
    it {is_expected.to validate_presence_of :first_name_furigana}
    it {is_expected.to validate_length_of(:first_name_furigana).is_at_most(10)}
    it {is_expected.to validate_length_of(:first_name_furigana).is_at_least(2)}
    it {is_expected.to validate_presence_of :last_name}
    it {is_expected.to validate_length_of(:last_name).is_at_most(10)}
    it {is_expected.to validate_length_of(:last_name).is_at_least(2)}
    it {is_expected.to validate_presence_of :last_name_furigana}
    it {is_expected.to validate_length_of(:last_name_furigana).is_at_most(10)}
    it {is_expected.to validate_length_of(:last_name_furigana).is_at_least(2)}
    it {is_expected.to validate_presence_of :staff_id}
    it {is_expected.to validate_uniqueness_of(:staff_id)}
    it {is_expected.to validate_presence_of :level}
    it {is_expected.to validate_numericality_of(:level).only_integer}
    it {is_expected.to validate_presence_of :encrypted_password}
  end

  context "associations" do
    it {is_expected.to have_many(:admin_manage_users)}
    it {is_expected.to have_many(:working_records)}
  end
end
