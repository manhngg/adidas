# == Schema Information
#
# Table name: inventories
#
#  id          :bigint           not null, primary key
#  start_time  :datetime
#  finish_time :datetime
#  status      :string(255)
#  store_id    :bigint
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Inventory < ApplicationRecord
  # TODO: delete optional after set store
  belongs_to :store, optional: true
  after_create :create_product_inventories
  after_create :create_shelf_inventories

  has_many :shelf_inventories, dependent: :destroy
  has_many :product_inventories, dependent: :destroy
  has_many :shelf_stock_inventories, dependent: :destroy

  enum status: { unstarted: 0, started: 1, done: 2 }

  def create_product_inventories
    stock_json = Stock.left_joins(:product).select(:price, :stock_count).select('products.name as product_name, products.jan_code').as_json
    stock_json = stock_json.map{|x| x.merge!({inventory_id: self.id})}
    ProductInventory.bulk_insert values: stock_json
  end

  def create_shelf_inventories
    shelf_json = Shelf.select("name as shelf_name").as_json
    shelf_json = shelf_json.map{|x| x.merge!({inventory_id: self.id})}
    ShelfInventory.bulk_insert values: shelf_json
  end
end
