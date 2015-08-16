
Selva::CLI.class_eval do
  desc "server", "Run the server"
  def server
    require 'rack/handler/puma'

    root = 4.times.reduce(__FILE__) {|x,| File.dirname(x)}

    server = Selva::Server.new(
      root: root
    )
    
    Rack::Handler.get(:puma).run(server, :Port => 4567)
  end

  map 's' => 'server'
end