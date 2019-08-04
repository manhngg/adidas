if @order_item
	json.order_item do
		json.jan_code @product.jan_code
		json.product_name @product.name
		json.order_count @order_item.order_count
	end
else
	json.message "Error"
end
