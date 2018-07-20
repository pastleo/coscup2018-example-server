# frozen_string_literal: true

module SerializerSpecHelper
  def serialized_json(obj, opts = {})
    ActiveModelSerializers::SerializableResource.new(obj, opts).to_json
  end

  def serializable_hash(obj, opts = {})
    ActiveModelSerializers::SerializableResource.new(obj, opts).as_json
  end
end

RSpec.configure do |config|
  config.include SerializerSpecHelper, type: :request
end
