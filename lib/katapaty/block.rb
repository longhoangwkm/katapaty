#
# Counterblock APIs
#
module Katapaty
  class Block
    class << self

      def request(method_name, payload={})
        client = RestClient::Resource.new Katapaty.configuration.counterblock_url
        request = { method: method_name, params: payload, jsonrpc: '2.0', id: '0' }.to_json
        response = JSON.parse client.post(request,
                      accept: 'json',
                      content_type: 'json' )
        raise JsonResponseError.new response if response.has_key? 'code'
        raise ResponseError.new response['error'] if response.has_key? 'error'
        response['result']
      end

      def method_missing(name, *args)
        args = args.nil? ? {} : args.first
        request(name, args)
      end
    end
  end
end
