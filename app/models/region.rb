# == Schema Information
#
# Table name: regions
#
#  id         :bigint           not null, primary key
#  name       :string(255)
#  order      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Region < ApplicationRecord
  has_many :prefectures
  has_many :areas
  has_many :stores

  validates :name, presence: true
end
