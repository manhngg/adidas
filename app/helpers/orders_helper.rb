module OrdersHelper
  def supplier_options(order)
    supplier= order&.supplier
    order.new_record? ? []:[[supplier&.name,supplier&.id]]
  end
end
