class Adrsbook < ApplicationRecord
  belongs_to :store
  belongs_to :adrsbook_subcategory

  CATEGORY = {intenal: "店内", office: "本店／他店", other: "取引先等"}

  validates :name, presence: true
  validates :tel1, numericality: {only_integer: true}
  validates :tel2, numericality: {only_integer: true}
  validates :tel3, numericality: {only_integer: true}
end
