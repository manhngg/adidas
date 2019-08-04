class Api::V1::Inspections::ShowOrder::OrderSerializer < ActiveModel::Serializer
  attributes :supplier_name, :order_date, :order_sum, :inspection_sum

  has_many :order_items

  def supplier_name
    object.supplier.name
  end

  def order_date
    object.order_date.strftime("%Y/%m/%d") if object.order_date
  end

  def order_sum
    object.order_count
  end

  def inspection_sum
    object.inspection_count
  end
end
