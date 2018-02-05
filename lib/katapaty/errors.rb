module Katapaty
  class JsonResponseError < StandardError; end

  class ResponseError < StandardError
    attr_reader :data_type
    attr_reader :data_args
    attr_reader :data_message
    attr_reader :code
    attr_reader :message_class

    def initialize(json)
      @message_class, @code = json['message'], json['code']
      json['data'].each_pair do |(k,v)|
        instance_variable_set '@data_%s' % k, v
      end if json.has_key? 'data'
      super
    end

    def message
      "#{@message_class}:#{@data_message}"
    end
  end
end
