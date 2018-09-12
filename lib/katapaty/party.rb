#
# Counterparty APIs
#

module Katapaty
  class Party
    class << self
      def get_running_info
        request(__method__.to_s)
      end

      def address_token_balance(address, token_name)
        rs = request('get_balances', {"filters": [{ "field": 'address', "op": '==', "value": address },
                                             { "field": 'asset', "op": '==', "value": token_name }]})
        return 0 if rs.blank?
        rs.first['quantity'].to_i
      end

      def get_asset_info(assets)
        request(__method__.to_s, { assets: assets })
      end

      def get_blocks(block_indexes)
        request(__method__.to_s, { block_indexes: block_indexes })
      end

      def getrawtransaction(tx_hash)
        request(__method__.to_s, { tx_hash: tx_hash })
      end

      def create_send(payload)
        request(__method__.to_s, payload)
      end

      def request(method_name, payload={})
        client = RestClient::Resource.new Katapaty.configuration.counterparty_url
        request = { method: method_name, params: payload, jsonrpc: '2.0', id: '0' }.to_json
        response = JSON.parse client.post(request,
                      accept: 'json',
                      content_type: 'json' )
        raise JsonResponseError.new response if response.has_key? 'code'
        raise ResponseError.new response['error'] if response.has_key? 'error'
        response['result']
      end
    end
  end
end
