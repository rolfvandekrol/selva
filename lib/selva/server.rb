require 'rack'

require 'active_support/core_ext/hash/reverse_merge'
require 'active_support/logger'
require 'active_support/tagged_logging'

module Selva
  class Server
    attr_reader :logger, :app

    def initialize(options = {})
      @options = options.reverse_merge(environment: :development)
      raise if @options[:root].nil?

      build_logger
      build_app
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

      def build_app
        builder = Rack::Builder.new

        if development?
          builder.instance_eval do
            use Rack::Reloader, 0
          end
        end

        server = self

        builder.instance_eval do

          use Rack::ContentLength
          run Selva::Router.new
        end

        @app = builder.to_app
      end

      def build_logger
        output = STDOUT
        output = File.join(root, 'log', "#{environment}.log") unless development?

        @logger = ActiveSupport::TaggedLogging.new(Logger.new(output))
      end
  end
end