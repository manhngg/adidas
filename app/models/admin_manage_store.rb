class AdminManageStore < ApplicationRecord
  belongs_to :admin
  belongs_to :store

  validates :role, numericality: {only_integer: true}
end
