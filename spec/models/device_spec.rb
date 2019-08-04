# == Schema Information
#
# Table name: devices
#
#  id                   :bigint           not null, primary key
#  number               :string(255)
#  name                 :string(255)
#  encrypted_password   :string(255)
#  registered           :boolean          default("no")
#  store_id             :bigint
#  transceiver_group_id :bigint
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

require 'rails_helper'

RSpec.describe Device, type: :model do
  context "column specifications" do
    it {is_expected.to have_db_column(:number).of_type(:string)}
    it {is_expected.to have_db_column(:name).of_type(:string)}
    it {is_expected.to have_db_column(:encrypted_password).of_type(:string)}
    it {is_expected.to have_db_column(:registered).of_type(:boolean)}
    it {is_expected.to have_db_column(:store_id).of_type(:integer)}
    it {is_expected.to have_db_column(:transceiver_group_id).of_type(:integer)}
  end

  context "associations" do
    it {is_expected.to belong_to(:store)}
    it {is_expected.to belong_to(:transceiver_group)}
  end

  context "validates" do
    it {is_expected.to validate_presence_of :name}
    it {is_expected.to validate_presence_of :encrypted_password}
    it {is_expected.to validate_length_of(:encrypted_password).is_at_least(8)}
  end
end
