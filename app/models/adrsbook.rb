# == Schema Information
#
# Table name: adrsbooks
#
#  id                      :bigint           not null, primary key
#  name                    :string(255)
#  furigana                :string(255)
#  category                :string(255)
#  tel1                    :string(255)
#  tel2                    :string(255)
#  tel3                    :string(255)
#  note                    :text(65535)
#  registered              :boolean
#  deleted                 :boolean
#  store_id                :bigint
#  adrsbook_subcategory_id :bigint
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#

class Adrsbook < ApplicationRecord
  acts_as_paranoid column: "deleted", column_type: "boolean"

  ATTRIBUTE_PARAMS = [:id, :name, :adrsbook_subcategory_id,
    :furigana, :category, :tel1, :tel2, :tel3, :store_id].freeze
  CATEGORY = {intenal: "店内", office: "本店／他店", other: "取引先等"}

  belongs_to :store
  belongs_to :adrsbook_subcategory, optional: true

  delegate :name, to: :adrsbook_subcategory,
    prefix: true, allow_nil: true

  validates :name, :furigana, presence: true,
    length: {maximum: 32}
  validates :category, presence: true
  validates :tel1, presence: true, numericality: {only_integer: true},
    length: {maximum: 11}
  validates :tel2, :tel3, numericality: {only_integer: true},
    allow_nil: true, length: {maximum: 11}

  scope :belong_to_store, ->(store_id){where store_id: store_id, deleted: nil}

  class << self
    def import file, store_id
      imported = {num: 0}
      CSV.foreach(file.path, headers: true, encoding: "Shift_JIS:UTF-8") do |row|
        row = row.to_hash
        @adrsbook = Adrsbook.find_by name: row["name"]
        @adrsbook_subcategory = AdrsbookSubcategory.find_by name:
          row["adrsbook_subcategory_name"]
        @store = Store.find_by name: row["store_name"]
        if @adrsbook.blank?
          @adrsbook = Adrsbook.new
        end
        @adrsbook.attributes = row.slice(*updatable_attributes)
        @adrsbook.store_id = store_id
        @adrsbook.adrsbook_subcategory_id = @adrsbook_subcategory.try(:id)
        if @adrsbook.save
          imported[:num] += 1
        else
          imported["#{$.}"] = "行#{$.}: #{@adrsbook.errors.full_messages.first}"
        end
      end
      imported[:num] = imported[:num].to_s + "件、作成しました"
      imported
    end

    def updatable_attributes
      ["name", "furigana", "category", "tel1", "tel2", "tel3"]
    end

    def load_categories
      Adrsbook::CATEGORY.map do |key, value|
        [value, key]
      end
    end
  end
end
