# CLI command to run the server. This fires up Puma and feeds the Selva::Server
# Rack app to it.

Selva::CLI.class_eval do
  desc "server", "Run the server"
  def server
    # Make sure the Puma Rack handler is available
    require 'rack/handler/puma'

    # Figure out the root path of the application. The server uses this to 
    # set the log location.
    root = 4.times.reduce(__FILE__) {|x,| File.dirname(x)}

    # Initalize the server rack app
    server = Selva::Server.new(
      root: root
    )

    # Run the rack app through Puma.
    Rack::Handler.get(:puma).run(server, :Port => 4567)
  end

  # Alias 's' to 'server'
  map 's' => 'server'
end