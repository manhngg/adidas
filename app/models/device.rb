class Device < ApplicationRecord
  belongs_to :store
  belongs_to :transceiver_group, optional: true

  validates :name, presence: true
  validates :encrypted_password, presence: true, length: {minimum: 6}

  def is_password? password
    BCrypt::Password.new(self.encrypted_password) == password
  end
end
