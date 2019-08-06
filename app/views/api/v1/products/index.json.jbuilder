json.products @products.each do |product|
  json.name product.name
  json.jan_code product.jan_code
end
