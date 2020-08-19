module Katapaty
  class Configuration
    attr_accessor :username,
      :password,
      :host,
      :port,
      :block_username,
      :block_password,
      :block_host,
      :block_port,
      :ssl

    def counterparty_url
      return 'http://rpc:1234@public.coindaddy.io:14000/api/' unless @host
      "#{protocol}://#{@username}:#{CGI.escape(@password)}@#{@host}:#{@port}/api/"
    end

    def counterblock_url
      return 'http://rpc:1234@public.coindaddy.io:14100/api/' unless @block_host
      authen = ''
      authen = "#{@block_username}:#{CGI.escape(@block_password)}@" if @block_username
      "#{protocol}://#{authen}#{@block_host}:#{@block_port}/api/"
    end

    private

    def protocol
      @ssl ? 'https' : 'http'
    end
  end
end
