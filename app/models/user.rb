# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  full_name              :string(255)
#  full_name_furigana     :string(255)
#  first_name             :string(255)
#  first_name_furigana    :string(255)
#  last_name              :string(255)
#  last_name_furigana     :string(255)
#  staff_id               :string(255)
#  level                  :integer
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable

  has_many :admin_manage_users, dependent: :destroy
  has_many :admins, through: :admin_manage_users
  has_many :working_records, dependent: :destroy
  has_many :record_reports, dependent: :destroy
  has_many :store_users, dependent: :destroy
  has_many :stores, through: :store_users

  before_validation :set_user_name

  validates :first_name, presence: true,
    length: {maximum: 10, minimum: 2}
  validates :first_name_furigana, presence: true,
    length: {maximum: 10, minimum: 2}
  validates :last_name, presence: true,
    length: {maximum: 10, minimum: 2}
  validates :last_name_furigana, presence: true,
    length: {maximum: 10, minimum: 2}
  validates :staff_id, presence: true, uniqueness: true
  # validates :encrypted_password, presence: true, length: {minimum: 8}

  def set_user_name
    self.full_name = first_name + last_name
    self.full_name_furigana = first_name_furigana + last_name_furigana
  end

  def email_required?
    false
  end

  def will_save_change_to_email?
    false
  end

  class << self
    def import(file, store_id)
      imported = {num: 0}
      CSV.foreach(file.path, headers: true, encoding: 'Shift_JIS:UTF-8') do |row|
        row = row.to_hash
        user = User.find_or_initialize_by(staff_id: row["staff_id"])
        user.attributes = row.slice(*updatable_attributes)
        user.store_users.build store_id: store_id
        if user.save
          imported[:num] += 1
        else
          imported["#{$.}"] = "行#{$.}: #{user.errors.full_messages.first}"
        end
      end
      imported[:num] = imported[:num].to_s + "件、作成しました"
      imported
    end

    def updatable_attributes
      ["staff_id", "last_name", "last_name_furigana", "first_name", "first_name_furigana", "department", "password"]
    end
  end
end
