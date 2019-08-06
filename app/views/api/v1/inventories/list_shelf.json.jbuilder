json.shelves @shelves do |shelf|
  json.id shelf.id
  json.name shelf.name
  json.col_count shelf.col_count
  json.row_count shelf.row_count
end
