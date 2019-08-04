class Area < ApplicationRecord
  belongs_to :prefecture

  has_many :stores

  validates :name, presence: true
end
