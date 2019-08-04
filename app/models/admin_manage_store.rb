# == Schema Information
#
# Table name: admin_manage_stores
#
#  id         :bigint           not null, primary key
#  admin_id   :bigint
#  store_id   :bigint
#  role       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class AdminManageStore < ApplicationRecord
  belongs_to :admin
  belongs_to :store
end
