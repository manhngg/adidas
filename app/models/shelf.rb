# == Schema Information
#
# Table name: shelves
#
#  id         :bigint           not null, primary key
#  name       :string(255)
#  row_count  :integer
#  col_count  :integer
#  store_id   :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Shelf < ApplicationRecord
  belongs_to :store

  has_many :shelf_stocks

  validates :name, presence: true
  validates :row_count, :col_count, numericality: {only_integer: true, less_than_or_equal_to: 9999999}

  def self.search(search_name)
    if search_name
      where(['name LIKE ? ', "%#{search_name}%"])
    else
      all
    end
  end

  def self.import(file, store_id)
    Shelf.delete_all
    imported = {num: 0}
    CSV.foreach(file.path, headers: true, encoding: 'Shift_JIS:UTF-8') do |row|
      row = row.to_hash
      shelf = Shelf.new
      shelf.attributes = row.slice(*updatable_attributes)
      shelf.store_id = store_id
      if shelf.save
        imported[:num] += 1
      else
        imported["#{$.}"] = "行#{$.}: #{shelf.errors.full_messages.first}"
      end
    end
    imported[:num] = imported[:num].to_s + "件、作成しました"
    imported
  end

  def self.updatable_attributes
    ["name", "row_count", "col_count"]
  end
end
