if @orders.any?
	json.orders @orders do |order|
		json.id order.id
		json.order_number order.order_number
		json.supplier_name order.supplier.name
		json.delivery_date order.order_items.minimum(:delivery_date).strftime("%Y-%m-%d") if order.order_items.any?
		json.order_sum order.order_count
		json.inspection_sum order.inspection_count
		if order.order_items.any?
			json.order_items order.order_items.order("delivery_date ASC") do |order_item|
				json.id order_item.id
				json.product_name order_item.product.name
				json.jan_code order_item.product.jan_code
				json.delivery_date order_item.delivery_date.strftime("%Y-%m-%d")
				json.order_count order_item.order_count
        json.inspection_count order_item.inspection.inspection_count
			end
		end
	end
else
	json.message "No orders"
end
