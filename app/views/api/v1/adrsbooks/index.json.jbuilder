json.adrsbooks @categories do |category|
  adrsbooks = @store.adrsbooks.where(category: category[0])
  json.array! adrsbooks do |adrsbook|
    json.id adrsbook.id
    json.name adrsbook.try(:name)
    json.furigana adrsbook.furigana
    json.tel1 adrsbook.tel1
    json.tel2 adrsbook.tel2
    json.tel3 adrsbook.tel3
    json.adrsbook_subcategory adrsbook.adrsbook_subcategory.try(:name)
  end
end
