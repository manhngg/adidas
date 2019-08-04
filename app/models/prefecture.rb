class Prefecture < ApplicationRecord
  belongs_to :region

  has_many :areas

  validates :name, presence: true
end
