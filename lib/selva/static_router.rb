require 'rack/request'

module Selva
  class StaticRouter
    # We route the request using regular expressions.
    REQUEST_MAPPING = {
      # Serve the homepage as a normal page
      /^\/$/ => :serve_page,

      # User generated pages are located on /u/.
      /^\/u\// => :serve_page,
    }

    attr_reader :server

    def initialize(server)
      @server = server
    end

    def call(env)
      # We use the Rack::Request wrapper around the env, to access the request
      # parameters a little easier.
      request = Rack::Request.new(env)

      # Figure out which route we should use to serve the request.
      route = REQUEST_MAPPING.find do |regexp, callback|
        regexp.match request.path_info
      end

      # Serve a 404 when no route is found.
      return serve_not_found(request) if route.nil?

      # Serve from the callback that belongs to the found route.
      send(route[1], request)
    end

    def serve_page(request)
      [200, {'Content-Type' => 'text/html'}, [page_html]]
    end

    def page_html
%{<!doctype html>
<html>
  <head>
    <title>Selva</title>
  </head>
  <body>
    <div id="wrapper"></div>
    <script src="/a/application.js"></script>
  </body>
</html>}
    end

    def serve_not_found(request)
      [404, {'Content-Type' => 'text/html'}, ["<html><body><h1>Not found</h1><body></html>"]]
    end
  end
end