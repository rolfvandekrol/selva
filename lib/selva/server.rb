require 'rack'

require 'active_support/core_ext/hash/reverse_merge'

module Selva
  class Server
    def initialize(options = {})
      @options = options.reverse_merge(development: true)
      build_app
    end

    def call(env)
      @app.call(env)
    end

    protected

      def build_app
        options = @options
        @app = Rack::Builder.new do
          if options[:development]
            use Rack::Reloader, 0
          end

          use Rack::ContentLength
          run Selva::Router.new
        end.to_app
      end
  end
end