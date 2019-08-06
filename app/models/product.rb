# == Schema Information
#
# Table name: products
#
#  id         :bigint           not null, primary key
#  name       :string(255)
#  jan_code   :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Product < ApplicationRecord
  has_many :order_items, dependent: :destroy
  has_many :stocks, dependent: :destroy

  validates :name, presence: true
  validates :jan_code, presence: true, uniqueness: {case_sensitive: false},
    length: {maximum: 13}

  def self.search(search_name, search_jan)
    if search_name || search_jan
      where(['name LIKE ? and jan_code LIKE ? ', "%#{search_name}%", "%#{search_jan}%"])
    else
      all
    end
  end

  class << self
    def import(file)
      imported = {num: 0}
      CSV.foreach(file.path, headers: true) do |row|
        row = row.to_hash
        product = Product.find_or_initialize_by name: row["jan_code"]
        product.attributes = row.slice(*updatable_attributes)

        if product.save
          imported[:num] += 1
        else
          imported["#{$.}"] = "行#{$.}: #{product.errors.full_messages.first}"
        end
      end
      imported[:num] = imported[:num].to_s + "件、作成しました"
      imported
    end

    def updatable_attributes
      ["name","jan_code"]
    end
  end
end
