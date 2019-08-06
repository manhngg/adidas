json.regions @regions.each do |region|
  json.id region.id
  json.name region.name
  json.prefectures region.prefectures.each do |prefecture|
    json.id prefecture.id
    json.name prefecture.name
    json.areas prefecture.areas.each do |area|
      json.id area.id
      json.name area.name
      json.stores area.stores.each do |store|
        json.id store.id
        json.name store.name
      end
    end
  end
end
