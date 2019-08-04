class Store < ApplicationRecord
  belongs_to :area

  has_many :api_keys
  has_many :adrsbooks
  has_many :admin_manage_stores
  has_many :devices
  has_many :inventories
  has_many :message_groups
  has_many :shelves
  has_many :store_users
  has_many :orders
  has_many :record_reports
  has_many :stocks
  has_many :products, through: :stocks
  has_many :transceiver_groups
  has_many :products, through: :stocks
  has_many :product_inventories, through: :inventories
  has_many :inspection_errors

  validates :name, presence: true
end
