class Api::V1::Products::Index::ProductSerializer < ActiveModel::Serializer
  attributes :name, :jan_code
end
