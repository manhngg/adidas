# == Schema Information
#
# Table name: suppliers
#
#  id              :bigint           not null, primary key
#  supplier_number :string(255)
#  name            :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Supplier < ApplicationRecord
  has_many :orders, dependent: :destroy
  has_many :order_items, dependent: :destroy

  validates :name, presence: true
  validates :supplier_number, presence: true, numericality: {only_integer: true}, length: {maximum: 20}

  def self.import(file)
    imported = {num: 0}
    CSV.foreach(file.path, headers: true, encoding: 'Shift_JIS:UTF-8') do |row|
      row = row.to_hash
      supplier = Supplier.find_or_initialize_by name: row["supplier_number"]
      supplier.attributes = row.slice(*updatable_attributes)
      if supplier.save
        imported[:num] += 1
      else
        imported["#{$.}"] = "行#{$.}: #{supplier.errors.full_messages.first}"
      end
    end
    imported[:num] = imported[:num].to_s + "件、作成しました"
    imported
  end

  def self.updatable_attributes
    ["supplier_number","name","furigana"]
  end
end
