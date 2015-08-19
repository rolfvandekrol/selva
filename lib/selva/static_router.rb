require 'rack/request'

require 'sprockets'
require 'react-jsx-sprockets'

module Selva
  class StaticRouter
    # We route the request using regular expressions.
    REQUEST_MAPPING = {
      # Serve the homepage as a normal page
      /^\/$/ => :serve_page,

      # All assets are located on /a/. For safety, we only accept dots in the
      # path when it is surrounded by letters, numbers or underscores.
      /^\/a(\/([a-z0-9\-]|[a-z0-9\-]\.[a-z0-9\-])+)+$/ => :serve_asset,

      # User generated pages are located on /u/.
      /^\/u\// => :serve_page,
    }

    attr_reader :server, :sprockets_environment

    def initialize(server)
      @server = server

      @sprockets_environment = Sprockets::Environment.new(server.root)
      @sprockets_environment.append_path('assets')
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
      [200, {'Content-Type' => 'text/html'}, ["<html><body><pre>Page: #{request.path_info}</pre><body></html>"]]
    end

    def serve_asset(request)
      path = Rack::Utils.unescape(request.path_info.to_s.sub(/^\/a\//, ''))
      asset = sprockets_environment[path]

      return serve_not_found(request) if asset.nil?

      headers = {}

      # Set content length header
      headers["Content-Length"] = asset.length.to_s

      # Set content type header
      if type = asset.content_type
        # Set charset param for text/* mime types
        if type.start_with?("text/") && asset.charset
          type += "; charset=#{asset.charset}"
        end
        headers["Content-Type"] = type
      end

      # Set caching headers
      headers["Cache-Control"] = "public"
      headers["ETag"]          = %("#{asset.etag}")
      headers["Cache-Control"] << ", must-revalidate"
      headers["Vary"] = "Accept-Encoding"

      [ 200, headers, asset ]
    end

    def serve_not_found(request)
      [404, {'Content-Type' => 'text/html'}, ["<html><body><h1>Not found</h1><body></html>"]]
    end
  end
end