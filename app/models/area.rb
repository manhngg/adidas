# == Schema Information
#
# Table name: areas
#
#  id            :bigint           not null, primary key
#  name          :string(255)
#  order         :integer
#  prefecture_id :bigint
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Area < ApplicationRecord
  belongs_to :region
  belongs_to :prefecture

  has_many :stores

  validates :name, presence: true

  def self.import(file)
    imported = {num: 0}
    CSV.foreach(file.path, headers: true, encoding: 'Shift_JIS:UTF-8') do |row|
      row = row.to_hash
      region = Region.find_by(name: row["region_name"])
      prefecture = region.prefectures.find_by(name: row["prefecture_name"]) if region
      if prefecture && region
        area = prefecture.areas.find_by(name: row["area_name"])

        if area.blank?
          area = Area.new name: row["area_name"], prefecture_id: prefecture.id, region_id: region.id
          if area.save
            imported[:num] += 1
          else
            imported["#{$.}"] = "行#{$.}: #{area.errors.full_messages.first}"
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
