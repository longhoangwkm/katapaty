module RPCServiceHelper
  def service(name, &block)
    context "'#{name}'" do
      define_method :fixture_name do
        name
      end

      define_method :result do |*args|
        FakeWeb.register_uri(:post, "http://user:pass@localhost:14000/api/", :response => fixture(fixture_name))
        Katapaty::Party.send(name, *args)
      end

      instance_eval &block
    end
  end
end
