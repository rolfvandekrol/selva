def fib(x)
  (x > 1) ? (fib(x-1) + fib(x-2)) : 1
end

Selva::CLI.class_eval do
  desc "server", "Run the server"
  def server
    require 'rack'
    require 'rack/handler/puma'

    app = lambda { |env| [200, {'Content-Type' => 'text/plain'}, ['OK']] }

    Rack::Handler.get(:puma).run(app, :Port => 4567)
  end

  map 's' => 'server'
end