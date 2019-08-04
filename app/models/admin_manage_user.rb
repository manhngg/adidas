# == Schema Information
#
# Table name: admin_manage_users
#
#  id         :bigint           not null, primary key
#  admin_id   :bigint
#  user_id    :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class AdminManageUser < ApplicationRecord
  belongs_to :admin
  belongs_to :user
end
