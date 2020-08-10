#
# Counterblock APIs
#
#
module Katapaty
  class Block
    class << self

      def request(method_name, params={})
        client = RestClient::Resource.new Katapaty.configuration.counterblock_url
        request = { method: method_name, params: params, jsonrpc: '2.0', id: '0' }.to_json
        response = JSON.parse client.post(
          request,
          accept: 'json',
          content_type: 'json'
        )
        raise JsonResponseError.new response if response.has_key? 'code'
        raise ResponseError.new response['error'] if response.has_key? 'error'
        response['result']
      end

      def method_missing(name, *args)
        params = args.nil? ? {} : args.first
        request(name, params)
      end

      def proxy_to_cp(method:, params: {})
        client = RestClient::Resource.new Katapaty.configuration.counterblock_url
        request = { method: :proxy_to_counterpartyd, params: { method: method, params: params }, jsonrpc: '2.0', id: '0' }.to_json
        response = JSON.parse client.post(
          request,
          accept: 'json',
          content_type: 'json'
        )
        raise JsonResponseError.new response if response.has_key? 'code'
        raise ResponseError.new response['error'] if response.has_key? 'error'
        response['result']
      end
    end
  end
end
