require 'rest-client'
require 'json'
require 'bitcoin'
require 'rc4'

require 'katapaty/version'
require 'katapaty/configuration'
require 'katapaty/errors'
require 'katapaty/tx_decode'

module Katapaty

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

    def method_missing(name, *args)
      args     = args.nil? ? nil : args.first
      client   = RestClient::Resource.new @configuration.api_url
      request  = { method: name, params: args, jsonrpc: '2.0', id: '0' }.to_json
      response = JSON.parse client.post(request,
                    user: @configuration.username,
                    password: @configuration.password,
                    accept: 'json',
                    content_type: 'json' )
      raise JsonResponseError.new response if response.has_key? 'code'
      raise ResponseError.new response['error'] if response.has_key? 'error'
      response['result']
    end
  end
end
