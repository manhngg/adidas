require 'rails_helper'

RSpec.describe Adrsbook, type: :model do
  context "column specifications" do
    it {is_expected.to have_db_column(:name).of_type(:string)}
    it {is_expected.to have_db_column(:furigana).of_type(:string)}
    it {is_expected.to have_db_column(:category).of_type(:string)}
    it {is_expected.to have_db_column(:tel1).of_type(:string)}
    it {is_expected.to have_db_column(:tel2).of_type(:string)}
    it {is_expected.to have_db_column(:tel3).of_type(:string)}
    it {is_expected.to have_db_column(:note).of_type(:text)}
    it {is_expected.to have_db_column(:registered).of_type(:integer)}
    it {is_expected.to have_db_column(:deleted).of_type(:integer)}
    it {is_expected.to have_db_column(:store_id).of_type(:integer)}
    it {is_expected.to have_db_column(:adrsbook_subcategory_id).of_type(:integer)}
  end

  context "associations" do
    it {is_expected.to belong_to(:store)}
    it {is_expected.to belong_to(:adrsbook_subcategory)}
  end

  context "validates" do
    it {is_expected.to validate_presence_of :name}
    it {is_expected.to validate_numericality_of(:tel1).only_integer}
    it {is_expected.to validate_numericality_of(:tel2).only_integer}
    it {is_expected.to validate_numericality_of(:tel3).only_integer}
  end
end
