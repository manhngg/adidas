# == Schema Information
#
# Table name: shelf_stocks
#
#  id         :bigint           not null, primary key
#  row        :integer
#  column     :integer
#  shelf_id   :bigint
#  stock_id   :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ShelfStock < ApplicationRecord
  belongs_to :shelf
  belongs_to :stock
end
