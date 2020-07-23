module RPCServiceHelper
  def service(method_name, &block)
    context "'#{name}'" do

      define_method :result do |*args|
      	binding.pry
        FakeWeb.register_uri(:post, "http://user:pass@localhost:14000/api/", :response => fixture(method_name))
        Katapaty::Party.send(method_name, *args)
      end

      instance_eval &block
    end
  end
end
