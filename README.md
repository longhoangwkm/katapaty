# Katapaty

A ruby gem for communicating with a Counterparty (Bitcoin / XCP) API server. Katapaty was inspired by counterparty_ruby.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'katapaty'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install katapaty

Set your own counterparty node configuration in `config/initializers/katapaty.rb`

```ruby
# This is testnet counterparty node of coindaddy, you can change your own server config
Katapaty.configure do |config|
  # For counterparty APIs
  config.username = 'rpc'
  config.password = '1234'
  config.host     = 'public.coindaddy.io'
  config.port     = 14000
  # For counterblock APIs
  config.block_username = 'rpc'
  config.block_password = '1234'
  config.block_host     = 'public.coindaddy.io'
  config.block_port     = 14100

  config.ssl = true
end
```

## Usage Example

```ruby
Katapaty::Party.create_send(
  source: "mypcUU2fYyJav7XUpPLtMVhuPupArLJtiM",
  destination: "mjtwweXS2u5q1Ybypb271Wmehmj9g1w2th",
  asset: "LONGDD",
  quantity: 50000
)
```

Check methods here: https://counterparty.io/docs/api/#read-api-function-reference

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/katapaty. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Katapaty project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/katapaty/blob/master/CODE_OF_CONDUCT.md).
