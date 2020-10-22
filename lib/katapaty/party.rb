#
# Counterparty APIs
#

module Katapaty
  class Party
    class << self
      def get_running_info
        request('get_running_info')
      end

      def address_token_balance(address:, token:, proxy: false)
        filters_params = {
          "filters": [
            { "field": 'address', "op": '==', "value": address },
            { "field": 'asset', "op": '==', "value": token }
          ]
        }
        if proxy
          response = Katapaty::Block.proxy_to_cp(method: :get_balances, params: filters_params)
        else
          response = request('get_balances', filters_params)
        end
        return 0 if response.blank?
        response.first['quantity'].to_i
      end

      def get_asset_info(assets)
        request('get_asset_info', { assets: assets })
      end

      def get_blocks(block_indexes)
        request('get_blocks', { block_indexes: block_indexes })
      end

      def getrawtransaction(tx_hash)
        request('getrawtransaction', { tx_hash: tx_hash })
      end

      def create_send(payload)
        request('create_send', payload)
      end

      def create_order(payload)
        request('create_order', payload)
      end

      def btc_unconfirm_balance(address)
        (unspent_txouts(address).map { |a| a['amount'] }.sum.to_d * 1e8).to_i
      end

      def unspent_txouts(address)
        request(:get_unspent_txouts, { address: address, unconfirmed: true })
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
