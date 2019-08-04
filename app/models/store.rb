# == Schema Information
#
# Table name: stores
#
#  id         :bigint           not null, primary key
#  name       :string(255)
#  area_id    :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Store < ApplicationRecord
  belongs_to :region
  belongs_to :prefecture
  belongs_to :area

  has_many :api_keys
  has_many :adrsbooks
  has_many :admin_manage_stores
  has_many :admins, through: :admin_manage_stores
  has_many :devices
  has_many :inventories
  has_many :message_groups
  has_many :shelves
  has_many :orders
  has_many :record_reports
  has_many :working_records
  has_many :stocks
  has_many :transceiver_groups
  has_many :products, through: :stocks
  has_many :product_inventories, through: :inventories
  has_many :store_users
  has_many :users, through: :store_users
  has_many :inspection_errors

  validates :name, presence: true

  delegate :name, to: :prefecture, prefix: true
  delegate :name, to: :area, prefix: true

  def self.import(file)
    imported = {num: 0}
    CSV.foreach(file.path, headers: true, encoding: 'Shift_JIS:UTF-8') do |row|
      row = row.to_hash
      region = Region.find_by name: row["region_name"]
      prefecture = region.prefectures.find_by(name: row["prefecture_name"]) if region
      area = prefecture.areas.find_by(name: row["area_name"]) if prefecture
      if region && prefecture && area
        store = area.stores.find_by(name: row["store_name"])
        if store.blank?
          store = Store.new name: row["store_name"], region_id: region.id,
            prefecture_id: prefecture.id, area_id: area.id
          if store.save
            imported[:num] += 1
          else
            imported["#{$.}"] = "行#{$.}: #{store.errors.full_messages.first}"
          end
        end
      else
        imported[:error] = "地域または県が見つかりませんでした"
      end
    end
    imported[:num] = imported[:num].to_s + "件、作成しました"
    imported
  end
end
