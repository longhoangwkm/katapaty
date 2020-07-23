require 'spec_helper'

RSpec.describe Katapaty::Party do
  before do
    Katapaty.configure do |config|
      config.username = 'user'
      config.password = 'pass'
      config.host     = 'localhost'
      config.port     = 14000
      config.ssl      = true
    end
  end

  it ".configuration" do
    expect(Katapaty.configuration.host).to eq('localhost')
    expect(Katapaty.configuration.username).to eq('user')
    expect(Katapaty.configuration.password).to eq('pass')
    expect(Katapaty.configuration.port).to eq(14000)
    expect(Katapaty.configuration.counterparty_url).to eq('https://user:pass@localhost:14000/api/')
  end
end
