class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable

  has_many :admin_manage_users
  has_many :users, through: :admin_manage_users
  has_many :admin_manage_stores

  validates :first_name, presence: true,
    length: {maximum: 10, minimum: 2}
  validates :first_name_furigana, presence: true,
    length: {maximum: 10, minimum: 2}
  validates :last_name, presence: true,
    length: {maximum: 10, minimum: 2}
  validates :last_name_furigana, presence: true,
    length: {maximum: 10, minimum: 2}
  validates :staff_id, presence: true, uniqueness: true
  validates :encrypted_password, presence: true, length: {minimum: 8}

  def email_required?
    false
  end

  def will_save_change_to_email?
    false
  end
end
