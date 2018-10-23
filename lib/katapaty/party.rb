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
        request(__method__, { assets: assets })
      end

      def get_blocks(block_indexes)
        request(__method__, { block_indexes: block_indexes })
      end

      def getrawtransaction(tx_hash)
        request(__method__, { tx_hash: tx_hash })
      end

      def create_send(payload)
        request(__method__, payload)
      end

      def btc_unconfirm_balance(address)
        get_unspent_txouts(address).map { |a| a['amount'] }.sum.to_d * 1e8).to_i
      end

      def get_unspent_txouts(address)
        request(__method__, { address: address, unconfirmed: true })
      end

      def request(method_name, payload={})
        client = RestClient::Resource.new Katapaty.configuration.counterparty_url
        request = { method: method_name.to_s, params: payload, jsonrpc: '2.0', id: '0' }.to_json
        response = JSON.parse client.post(request,
                      accept: 'json',
                      content_type: 'json' )
        raise Katapaty::JsonResponseError.new response if response.has_key? 'code'
        raise Katapaty::ResponseError.new response['error'] if response.has_key? 'error'
        response['result']
      end

      def method_missing(name, *args)
        args = args.nil? ? {} : args.first
        request(name, args)
      end
    end
  end
end
