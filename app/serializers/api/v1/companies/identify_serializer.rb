class Api::V1::Companies::IdentifySerializer < ActiveModel::Serializer
  attributes :name, :subdomain
end
