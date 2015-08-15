
Selva::CLI.class_eval do
  desc "server", "Run the server"
  def server
    require 'rack/handler/puma'
    Rack::Handler.get(:puma).run(Selva::Server.new, :Port => 4567)
  end

  map 's' => 'server'
end