module Selva
  class StaticRouter
    def call(env)
      [200, {'Content-Type' => 'text/html'}, ["<html><body><pre>#{env['rack.session'].instance_variable_get('@store').class.name}</pre><body></html>"]]
    end
  end
end