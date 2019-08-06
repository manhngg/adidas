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

class Device < ApplicationRecord
  before_create :encrypt_password
  before_create :generate_number

  belongs_to :store, optional: true
  belongs_to :transceiver_group, optional: true
  belongs_to :store
  belongs_to :transceiver_group, optional: true

  validates :name, presence: true
  validates :encrypted_password, presence: true, length: {minimum: 6}

  enum registered: { no: false, yes: true }

  # TODO: Confirm the rule
  def generate_number
    self.number = "28#{format('%03d', 1)}#{format('%09d', rand(10))}"
  end

  def encrypt_password
    self.encrypted_password = BCrypt::Password.create(self.encrypted_password)
  end

  def self.search(search_name, search_number)
    if search_name || search_number
      where(['name LIKE ? and number LIKE ? ', "%#{search_name}%", "%#{search_number}%"])
    else
      all
    end
  end

  def is_password? password
    BCrypt::Password.new(self.encrypted_password) == password
  end
end
