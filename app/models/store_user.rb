# == Schema Information
#
# Table name: store_users
#
#  id         :bigint           not null, primary key
#  store_id   :bigint
#  user_id    :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class StoreUser < ApplicationRecord
  belongs_to :store
  belongs_to :user
end
