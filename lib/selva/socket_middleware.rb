# We are using the faye-websocket library to perform the http to websocket
# upgrade and to implement the websocket communication.
require 'faye/websocket'

module Selva
  class SocketMiddleware
    # We keep the socket connection alive by sending a ping every 15 seconds.
    KEEPALIVE_TIME = 15

    def initialize(app, server)
      @app     = app
      @server  = server
      @clients = []
    end

    def call(env)
      # Write to the session so, the cookie will be sent. This way, we make sure
      # that when we write in the session from the websocket, this will be
      # saveable.
      env['rack.session']['init'] = true

      # If this is a http to websocket upgrade, initialize a websocket.
      if Faye::WebSocket.websocket?(env)
        ws = Faye::WebSocket.new(env, nil, {ping: KEEPALIVE_TIME })

        ws.on :open do |event|
          logger.tagged('Socket') { logger.info "Open #{ws.object_id}" }
          @clients << ws
        end

        ws.on :message do |event|
          logger.tagged('Socket') { logger.info "Message #{event.data}" }
          ws.send(event.data)
        end

        ws.on :close do |event|
          logger.tagged('Socket') { logger.info "Close #{ws.object_id}" }
          # p [:close, ws.object_id, event.code, event.reason]
          @clients.delete(ws)
          ws = nil
        end

        # Return async Rack response to acknowledge the websocket upgrade.
        ws.rack_response
      else
        # Pass through to the HTTP part of the Rack application.
        @app.call(env)
      end
    end

    private
      def logger
        @server.logger
      end
  end
end