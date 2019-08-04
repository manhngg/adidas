class Api::V1::Inspections::ListOrder::OrderSerializer < ActiveModel::Serializer
  attributes :id, :order_number, :supplier_name, :delivery_date, :order_sum, :inspection_sum

  def delivery_date
    object.order_items.minimum(:delivery_date).strftime("%Y/%m/%d") if object.order_items.present?
  end

  def supplier_name
    object.supplier.name
  end

  def order_sum
    object.order_count
  end

  def inspection_sum
    object.inspection_count
  end
end
