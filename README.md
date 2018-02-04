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

Set counterparty node configuration in `config/initializers/katapaty.rb`

```ruby
Katapaty.configure do |config|
  config.username = 'rpc'
  config.password = 'rpc'
  config.host     = '200.200.10.50'
  config.port     = 14000
end
```


## Usage Example

`Katapaty.create_send({source: "mypcUU2fYyJav7XUpPLtMVhuPupArLJtiM", destination: "mjtwweXS2u5q1Ybypb271Wmehmj9g1w2th", asset: "LONGDD", quantity: 50000})`

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/katapaty. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Katapaty project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/katapaty/blob/master/CODE_OF_CONDUCT.md).
