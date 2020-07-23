require 'spec_helper'

RSpec.describe 'RPC' do
  before do
    Katapaty.configure do |config|
      config.username = 'user'
      config.password = 'pass'
      config.host     = 'localhost'
      config.port     = 14000
    end
  end

  context "RPC" do
    extend RPCServiceHelper

    service 'get_running_info' do
      it "should produce the expected result" do
        expect(result).to eq({
          "indexd_blocks_behind"=>0,
          "version_revision"=>1,
          "running_regtest"=>false,
          "api_limit_rows"=>1000,
          "db_caught_up"=>true,
          "last_block"=>
          {"block_hash"=>"00000000000000000017cdb16a4beaab24b62041c2b6ebfc58c41ecbc8e6455a",
           "block_index"=>594108,
           "block_time"=>1568090242,
           "messages_hash"=>"e775aa75497338e595d6bb6b5e49bd11ba2946181a89b92faf78aafd0beb64a4",
           "ledger_hash"=>"e8ce6cfe43022d41245e16cfb5d37c70f24de47f507029ab12f9ba3970dc4b1b",
           "difficulty"=>10771996663680.396,
           "previous_block_hash"=>"000000000000000000160fc4fd481f9fde49990f181f5a10c3debb25958c891b",
           "txlist_hash"=>"4cd502d6f8019ab59464acd9909bf6ad8d88a8ae2e60a8619a2fcc5ec27b058d"},
           "running_testnet"=>false,
           "last_message_index"=>5475657,
           "bitcoin_block_count"=>594108,
           "server_ready"=>true,
           "version_major"=>9,
           "indexd_caught_up"=>true,
           "version_minor"=>56,
           "running_testcoin"=>false
        })
      end
    end

    service 'getrawtransaction' do
      it "should produce the expected result" do
        expect(result('4a9f77717b6e43d30b831fadd181696533f86f3a9266555f102e3ff7a20dfba7')).to
          eq(
          "010000000134045ae854f9ed4ccd9cf70523e8e67a55e6ddcdd615c0127e1c57d363e6559c010000"\
          "006b483045022100fdd312e4b25e61f6ae9993715a27ecf368b306de37fe62a71b859804c280fa370"\
          "22071c40e05b6e2a2ab5a33cef67d9d2d80c4952a3ee4822d8730d15a6c42ec14160121028c661bb0"\
          "3d755f834a47e5d267432ae2bb002a5a63af69fd0749892fb7966c03ffffffff020000000000000000"\
          "306a2eb23bc9df3967a58d7a99c5dd28d94cc4dc5c1ac298383706dcc98219fffd2f02a4797edd831f"\
          "09d1d2da213c2ec27b7a6901000000001976a914c8c934c4ad0fa394fd01747c375957f30752e26f88ac00000000")
      end
    end
  end
end
