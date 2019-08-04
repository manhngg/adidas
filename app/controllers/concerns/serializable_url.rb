module SerializableUrl
  extend ActiveSupport::Concern

  def set_url object, name_space
    ActiveModelSerializers::SerializableResource.new(object, {each_serializer: eval(name_space)}).to_json
  end
end
