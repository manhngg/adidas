# == Schema Information
#
# Table name: admins
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

class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable

  # after_save :create_or_update_user

  has_many :admin_manage_users, dependent: :destroy
  has_many :users, through: :admin_manage_users
  has_many :admin_manage_stores, dependent: :destroy
  has_many :stores, through: :admin_manage_stores
  accepts_nested_attributes_for :admin_manage_stores

  has_many :permissions, dependent: :destroy
  has_many :store_permissions, dependent: :destroy
  accepts_nested_attributes_for :permissions, allow_destroy: true
  accepts_nested_attributes_for :store_permissions, allow_destroy:true, reject_if: proc { |attributes| attributes['store_id'].blank? }

  # validates :first_name, presence: true,
  #   length: {maximum: 10, minimum: 2}
  # validates :first_name_furigana, presence: true,
  #   length: {maximum: 10, minimum: 2}
  # validates :last_name, presence: true,
  #   length: {maximum: 10, minimum: 2}
  # validates :last_name_furigana, presence: true,
  #   length: {maximum: 10, minimum: 2}
  # validates :staff_id, presence: true, uniqueness: true
  # validates :level, presence: true, numericality: {only_integer: true}
  # validates :encrypted_password, presence: true, length: {minimum: 8}

  before_validation :set_admin_name

  def set_admin_name
    self.full_name = first_name + last_name
    self.full_name_furigana = first_name_furigana + last_name_furigana
  end

  validates :first_name, presence: true,
    length: {maximum: 10, minimum: 2}
  validates :first_name_furigana, presence: true,
    length: {maximum: 10, minimum: 2}
  validates :last_name, presence: true,
    length: {maximum: 10, minimum: 2}
  validates :last_name_furigana, presence: true,
    length: {maximum: 10, minimum: 2}
  validates :staff_id, presence: true, uniqueness: true

  def email_required?
    false
  end

  def will_save_change_to_email?
    false
  end

  # def create_or_update_user
  #   user = User.find_or_initialize_by(staff_id: self.staff_id)

  #   user.last_name = self.last_name
  #   user.last_name_furigana = self.last_name_furigana
  #   user.first_name = self.first_name
  #   user.first_name_furigana = self.first_name_furigana
  #   user.department = self.department
  #   # TODO: set user password

  #   if user.valid?
  #     user.save!
  #   end
  # end

  class << self
    def import file
      imported = {num: 0}
      CSV.foreach(file.path, headers: true, encoding: 'Shift_JIS:UTF-8') do |row|
        row = row.to_hash
        admin = Admin.find_or_initialize_by(staff_id: row["staff_id"])
        admin.attributes = row.slice(*updatable_attributes)
        store = Store.find_by name: row["store_name"]
        admin.admin_manage_stores.build store_id: store.id if store
        if admin.save
          imported[:num] += 1
        else
          imported["#{$.}"] = "行#{$.}: #{admin.errors.full_messages.first}"
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
