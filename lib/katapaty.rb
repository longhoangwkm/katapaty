require 'rest-client'
require 'json'
require 'bitcoin'
require 'rc4'

require 'katapaty/version'
require 'katapaty/configuration'
require 'katapaty/errors'
require 'katapaty/tx_decode'
require 'katapaty/party'
require 'katapaty/block'

module Katapaty
  extend self

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
end
