require "ffaker"

puts "\n===== Creating fixed data for testing..."

print "Creating 100 products... "
100.times do
  Product.create!(
    name: FFaker::LoremJA.word,
    jan_code: FFaker::SSNSE.ssn
  )
end
puts "✔ Done"

print "Creating 100 suppliers... "
100.times do
  Supplier.create!(
    name: "#{FFaker::NameJA.last_name}会社",
    supplier_number: FFaker::SSNSE.ssn
  )
end
puts "✔ Done"

print "Creating 8 regions... "
["北海道", "東北", "関東", "中部", "関西", "中国", "四国", "九州"].each do |region|
  Region.create!(name: region)
end
puts "✔ Done"

print "Creating 8 prefectures of Kanto region... "
kanto = Region.find_by_name("関東")
["東京都", "埼玉県", "茨城県", "和奈川健", "山梨県", "群馬県", "栃木県", "千葉県"].each do |prefecture|
  Prefecture.create!(
    region: kanto,
    name: prefecture
  )
end
puts "✔ Done"

print "Creating 10 wards (areas) of Tokyo... "
tokyo = Prefecture.find_by_name("東京都")
["渋谷区", "千代田区", "中央区", "港区", "新宿区", "品川区", "大田区", "中野区", "北区", "江戸川区"].each do |area|
  Area.create!(
    prefecture: tokyo,
    name: area
  )
end
puts "✔ Done"

print "Creating Shibuya store of Shibuya ward... "
shibuya = Area.find_by_name("渋谷区")
shibuya_store = Store.create!(
  # region: kanto,
  # prefecture: tokyo,
  area: shibuya,
  name: "渋谷店"
)
puts "✔ Done"

print "Creating transceiver group of Shibuya store... "
TransceiverGroup.create!(
  store: shibuya_store,
  name: "レジ",
  sip_id: FFaker::Code.ean
)
puts "✔ Done"

print "Creating message group of Shibuya store... "
MessageGroup.create!(
  store: shibuya_store,
  name: "ペット売場"
)
puts "✔ Done"

print "Creating device of Shibuya store... "
Device.create!(
  store: shibuya_store,
  number: 111111,
  name: FFaker::Name.name,
  encrypted_password: BCrypt::Password.create("123456"),
  registered: 0
)
puts "✔ Done"

print "Creating 1 admin... "
admin = Admin.create!(
  full_name: "管理太郎",
  full_name_furigana: "かんりたろう",
  first_name: "太郎",
  first_name_furigana: "たろう",
  last_name: "管理",
  last_name_furigana: "かんり",
  staff_id: "999",
  password: "123456",
  password_confirmation: "123456"
)
puts "✔ Done"

print "Creating 1 user... "
user = User.create!(
  full_name: "安永優都",
  full_name_furigana: "やすながゆうと",
  first_name: "優都",
  first_name_furigana: "ゆうと",
  last_name: "安永",
  last_name_furigana: "やすなが",
  staff_id: "111"
)
puts "✔ Done"

print "Creating 1 user above work in Shibuya store... "
StoreUser.create!(
  store: shibuya_store,
  user: user,
)
puts "✔ Done"

print "Creating 10 orders of Shibuya store... "
10.times do
  order_date = FFaker::Time.between(Date.current - 30.days, Date.current - 15.days)
  shibuya_store.orders.create!(
    store: shibuya_store,
    order_date: order_date,
    order_number: FFaker::Address.building_number,
    order_count: 400,
    inspected: rand(0..1),
    inspection_count: 400,
    last_inspection: FFaker::Time.between(order_date, order_date + 15.days),
    supplier_id: rand(1..100)
  )
end
puts "✔ Done"

print "Creating 10 order items of order above... "
10.times do
  order = Order.first
  OrderItem.create!(
    order: order,
    order_count: 40,
    delivery_date: FFaker::Time.between(order.order_date, order.order_date + 15.days),
    product_id: rand(1..100),
    supplier_id: rand(1..100)
  )
end
puts "✔ Done"

print "Creating 10 inspections belongs to 10 order items above... "
OrderItem.all.each do |order_item|
  Inspection.create!(
    order: order_item.order,
    order_item: order_item,
    inspection_count: order_item.order_count
  )
end
puts "✔ Done"

print "Creating first 50 product stock for Shibuya store... "
Product.first(50).each do |product|
  Stock.create!(
    stock_count: rand(1..100),
    price: rand(100..10000),
    store: shibuya_store,
    product: product
  )
end
puts "✔ Done"

print "Creating inventory of Shibuya store... "
  Inventory.create!(
    store: shibuya_store,
    start_time: Time.current,
    status: 0
  )
puts "✔ Done"

print "Creating shelf inventory belongs to inventory above... "
shibuya_store.shelves.each do |shelf|
  ShelfInventory.create!(
    shelf_name: shelf.name,
    status: 0,
    inventory_id: 1
  )
end
puts "✔ Done"

print "Creating product inventory belongs to inventory above... "
shibuya_store.stocks.each do |stock|
  ProductInventory.create!(
    product_name: stock.product.name,
    jan_code: stock.product.jan_code,
    stock_count: stock.stock_count,
    inventory_count: 0,
    # price: stock.price,
    inventory_id: 1
  )
end
puts "✔ Done"

print "Creating API key... "
ApiKey.create!(
  store_id: 1,
  key_name: "Key 1",
  key_value: "testkey"
)
puts "✔ Done"

print "Creating 5 companies... "
5.times do |i|
  Company.create!(
    name: "株式会社 #{FFaker::NameJA.last_name}",
    subdomain: "c#{i+1}"
  )
end
puts "✔ Done"
