# == Schema Information
#
# Table name: prefectures
#
#  id         :bigint           not null, primary key
#  name       :string(255)
#  order      :integer
#  region_id  :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Prefecture < ApplicationRecord
  belongs_to :region

  has_many :areas
  has_many :stores

  validates :name, presence: true
end
