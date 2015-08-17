require 'rack'

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
        builder = Rack::Builder.new

        if development?
          builder.instance_eval do
            use Rack::Reloader, 0
          end
        end

        server = self

        builder.instance_eval do
          use Selva::SocketMiddleware, server

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