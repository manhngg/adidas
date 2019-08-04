require "ffaker"

puts "\n===== Creating common data for testing..."

print "Creating 100 stores in Tokyo... "
100.times do
  area = Area.find(rand(1..10))
  Store.create!(
    area: area,
    name: FFaker::AddressJA.village.gsub("村", "店")
  )
end
puts "✔ Done"

print "Creating 100 shelves of first 5 stores... "
100.times do
  Shelf.create!(
    store_id: rand(1..5),
    row_count: rand(5..10),
    col_count: rand(10..50),
    name: FFaker::JobJA.title
  )
end
puts "✔ Done"

print "Creating 100 transceiver groups of first 10 stores... "
100.times do |i|
  TransceiverGroup.create!(
    store_id: rand(1..10),
    name: FFaker::JobJA.title,
    sip_id: FFaker::Code.ean
  )
end
puts "✔ Done"

print "Creating 50 message groups of first 10 stores... "
50.times do |i|
  MessageGroup.create!(
    store_id: rand(1..10),
    name: FFaker::JobJA.title
  )
end
puts "✔ Done"

print "Creating 500 messages of first 10 message groups... "
500.times do
  Message.create!(
    message_group_id: rand(1..10),
    submit_user_name: FFaker::NameJA.name,
    msg_text: FFaker::LoremJA.sentence,
    created_at: FFaker::Time.between(Date.current - 30.days, Date.current - 1.days)
  )
end
puts "✔ Done"

print "Creating 100 devices of first 10 stores... "
100.times do
  Device.create!(
    store_id: rand(1..10),
    number: FFaker::Code.ean,
    name: FFaker::NameJA.name,
    encrypted_password: BCrypt::Password.create("123456"),
    registered: 0
  )
end
puts "✔ Done"

print "Creating 10 adrsbook subcategories... "
10.times do |i|
  AdrsbookSubcategory.create!(
    name: FFaker::JobJA.title,
    order: i+1
  )
end
puts "✔ Done"

print "Creating 100 adrsbooks in first 5 stores... "
100.times do |i|
  Adrsbook.create!(
    store_id: rand(1..5),
    name: FFaker::NameJA.name,
    furigana: ["スズキイッキ", "タカダスミレ", "ヨシモトユウカ", "ヤマモトタトウ", "サトウヒロキ", "マツダユウカ", "タカヨシダイキ", "ヤマモトタケシ", "ヒラモトミユ", "トミタヒデオ"].sample,
    category: ["intenal", "office", "other"].sample,
    tel1: FFaker::PhoneNumber.short_phone_number.gsub("-", ""),
    tel2: FFaker::PhoneNumber.short_phone_number.gsub("-", ""),
    tel3: FFaker::PhoneNumber.short_phone_number.gsub("-", ""),
    adrsbook_subcategory_id: rand(1..10)
  )
end
puts "✔ Done"

print "Creating 100 stocks for first 5 stores... "
Product.all.each do |product|
  Stock.create!(
    stock_count: rand(1..100),
    price: rand(100..10000),
    store_id: rand(2..6),
    product: product
  )
end
puts "✔ Done"

print "Creating 4 record actions... "
["出勤", "休憩入り", "休憩戻り", "退勤"].each_with_index do |action, index|
  RecordAction.create!(
    name: action,
    order: index+1
  )
end
puts "✔ Done"

puts "\n===== Finished ====="
