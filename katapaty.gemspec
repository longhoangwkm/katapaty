
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "katapaty/version"

Gem::Specification.new do |spec|
  spec.name          = "katapaty"
  spec.version       = Katapaty::VERSION
  spec.authors       = ["longhoang.wkm"]
  spec.email         = ["longhoang@wakumo.vn"]

  spec.summary       = "A ruby gem for communicating with a Counterparty (Bitcoin / XCP) API server"
  spec.license       = "MIT"
  spec.homepage      = "https://github.com/longhoangwkm/katapaty"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'bundler', "~> 1.16"
  spec.add_development_dependency 'rake', "~> 10.0"
  spec.add_development_dependency 'rspec', "~> 3.0"
  spec.add_development_dependency 'pry-rails'
  spec.add_development_dependency 'fakeweb'

  spec.add_dependency "json"
  spec.add_dependency "rest-client"
  spec.add_dependency "bitcoin-ruby"
  spec.add_dependency "ruby-rc4", "~> 0.1.5"
  spec.add_dependency "ffi"
end
