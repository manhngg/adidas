class Region < ApplicationRecord
  has_many :prefectures

  validates :name, presence: true
end
