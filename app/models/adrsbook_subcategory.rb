class AdrsbookSubcategory < ApplicationRecord
  has_many :adrsbooks

  validates :name, presence: true
  validates :order, numericality: {only_integer: true}
end
