require "spec_helper"

RSpec.describe "#configure" do

  before :each do
    Katapaty.configure do |config|
      config.username = 'Long'
    end
  end

  it "returns a configed username" do
    username = Katapaty.configuration.username
    expect(username).to eq('Long')
  end

  after :each do
    Katapaty.reset
  end

end

RSpec.describe ".reset" do

  before :each do
    Katapaty.configure do |config|
      config.port = 14000
    end
  end

  it "resets the configuration" do
    Katapaty.reset
    config = Katapaty.configuration
    expect(config.port).to eq(nil)
  end

end
