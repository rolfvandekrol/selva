require 'faye/websocket'

module Selva
  class SocketMiddleware
    KEEPALIVE_TIME = 15 # in seconds

    def initialize(app, server)
      @app     = app
      @server  = server
      @clients = []
    end

    def call(env)
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

        # Return async Rack response
        ws.rack_response
      else
        @app.call(env)
      end
    end

    private
      def logger
        @server.logger
      end
  end
end