require 'katapaty/version'
require 'katapaty/configuration'
require 'katapaty/resource'
require 'katapaty/resources'
require 'katapaty/errors'

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
