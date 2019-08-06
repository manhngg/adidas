json.order do
  json.supplier_name @order.supplier.name
  json.order_date @order.order_date.strftime("%Y/%m/%d") if @order.order_date
  json.order_sum @order.order_count
  json.inspection_sum @order.inspection_count

  json.order_items @order.order_items do |order_item|
    json.product_name order_item.product.name
    json.jan_code order_item.product.jan_code
    json.delivery_date order_item.delivery_date.strftime("%Y/%m/%d") if order_item.delivery_date
    json.order_count order_item.order_count
    json.inspection_count order_item.inspection.inspection_count if order_item.inspection
  end
end
