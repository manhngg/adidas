# == Schema Information
#
# Table name: adrsbook_subcategories
#
#  id         :bigint           not null, primary key
#  name       :string(255)
#  order      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class AdrsbookSubcategory < ApplicationRecord
  include RailsSortable::Model
  set_sortable :order

  ATTRIBUTE_PARAMS = [:id, :name, :order].freeze

  has_many :adrsbooks, dependent: :nullify

  validates :name, presence: true
  validates :order, numericality: {only_integer: true}
end
