class Api::V1::Inspections::ShowOrder::OrderItemSerializer < ActiveModel::Serializer
  attributes :product_name, :jan_code, :delivery_date, :order_count, :inspection_count

  def product_name
    object.product.name
  end

  def jan_code
    object.product.jan_code
  end

  def delivery_date
    object.delivery_date.strftime("%Y/%m/%d") if object.delivery_date
  end

  def inspection_count
    object.inspection.inspection_count if object.inspection
  end
end
