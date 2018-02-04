require 'katapaty/version'
require 'katapaty/configuration'
require 'katapaty/resource'
require 'katapaty/resources'

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
      '%s: %s' % [@message_class,@data_message]
    end
  end

  class << self
    attr_writer :configuration

    def configuration
      @configuration ||= Configuration.new
    end

    def reset
      @configuration = Configuration.new
    end

    def configure
      yield(configuration)
    end

    def request(method, params)
      client   = RestClient::Resource.new @configuration.api_url
      request  = { method: method, params: params, jsonrpc: '2.0', id: '0' }.to_json
      response = JSON.parse client.post(request,
                    user: @configuration.username,
                    password: @configuration.password,
                    accept: 'json',
                    content_type: 'json' )
      raise JsonResponseError.new response if response.has_key? 'code'
      raise ResponseError.new response['error'] if response.has_key? 'error'
      response['result']
    end

    Katapaty::Resources.constants.each do |c|
      begin
        define_method(:"get_#{c.to_s.pluralize.downcase}") do |params|
          self.request((__method__).to_s, params)
        end
        define_method(:"create_#{c.to_s.downcase}") do |params|
          self.request((__method__).to_s, params)
          end
      rescue NameError
        next
      end
    end
  end
end
