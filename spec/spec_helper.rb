require "bundler/setup"
require "katapaty"
require 'fakeweb'
require 'pry'

require File.expand_path('../lib/katapaty', File.dirname(__FILE__))
Dir[File.expand_path("support/**/*.rb", File.dirname(__FILE__))].each { |f| require f }

RSpec.configure do |config|
  config.example_status_persistence_file_path = ".rspec_status"
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.after :each do
    Katapaty.reset
  end

  config.include FixturesHelper
  config.before { FakeWeb.allow_net_connect = false }
  config.after  { FakeWeb.allow_net_connect = true  }
end
