class Api::V1::Inventories::ListShelf::ShelfSerializer < ActiveModel::Serializer
  attributes :id, :name, :col_count, :row_count
end
