require 'rack'
require 'rack/session/pool'

require 'active_support/core_ext/hash/reverse_merge'

require 'active_support/logger'
require 'active_support/tagged_logging'

require 'active_support/callbacks'


module Selva
  class Server
    include ActiveSupport::Callbacks
    define_callbacks :initialize

    attr_reader :logger, :app

    def initialize(options = {})
      @options = options.reverse_merge(environment: :development)
      raise if @options[:root].nil?

      protected_methods.grep(/^initialize_/).each do |method|
        send(method)
      end
    end

    def call(env)
      app.call(env)
    end

    def development?
      environment == :development
    end

    def environment
      @options[:environment]
    end

    def root
      @options[:root]
    end

    protected

      def initialize_app
        # Build the Rack app here. The request first hits the first middleware
        # and then down the list of middlewares until it reaches the app. The
        # response goes the other way around, so starts at the last middleware
        # and finishes with the first. 
        # Notice that the bulk of the client - server communication will not be
        # using this Rack app, but will be using the websocket connection that
        # is initialized in Selva::SocketMiddleware.
        builder = Rack::Builder.new

        # First we make sure the register the Rack::Reloader middleware. This
        # reloads all changed required files. Works pretty well with reloading
        # the app. Some things don't get reloaded, but I think those are the
        # least moving parts, so that won't be very annoying.
        if development?
          builder.instance_eval do
            use Rack::Reloader, 0
          end
        end

        # Make sure we can access the server from the builder instance
        server = self

        builder.instance_eval do

          # Add the session handler. We will probably want to switch this to a
          # memcached handler for production use, but for development the pool
          # is probably fine.
          use Rack::Session::Pool, :expire_after => 2592000

          # Initialize the websocket connection here. All code below this line
          # will only be used to server the client side code (HTML and assets).
          # The Websocket negotiation will be answered from this middelware 
          # class and will not touch the middelware defined below, nor the
          # application.
          use Selva::SocketMiddleware, server

          # Initialize the HTTP application
          use Rack::ContentLength
          run Selva::Router.new
        end

        @app = builder.to_app
      end
      set_callback :initialize, :after, :build_app

      def initialize_logger
        output = STDOUT
        output = File.join(root, 'log', "#{environment}.log") unless development?

        @logger = ActiveSupport::TaggedLogging.new(Logger.new(output))
      end
      set_callback :initialize, :after, :build_logger
  end
end