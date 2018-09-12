module Katapaty
  class Configuration
    attr_accessor :username,
                  :password,
                  :host,
                  :port,
                  :block_username,
                  :block_password,
                  :block_host,
                  :block_port

    def counterparty_url
      return 'http://rpc:1234@public.coindaddy.io:14000/api/' unless @host
      "http://#{@username}:#{@password}@#{@host}:#{@port}/api/"
    end

    def counterblock_url
      return 'http://rpc:1234@public.coindaddy.io:14100/api/' unless @block_host
      "http://#{@block_username}:#{@block_password}@#{@block_host}:#{@block_port}/api/"
    end
  end
end
