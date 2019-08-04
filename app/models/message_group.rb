class MessageGroup < ApplicationRecord
  belongs_to :store

  has_many :messages

  validates :name, presence: true
end
