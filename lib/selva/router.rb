module Selva
  class Router
    def call(env)
      [200, {'Content-Type' => 'text/html'}, ['<html><body><body></html>']]
    end
  end
end