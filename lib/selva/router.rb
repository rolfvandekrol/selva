module Selva
  class Router
    def call(env)
      sleep 4
      [200, {'Content-Type' => 'text/plain'}, [Thread.current.object_id.to_s]]
    end
  end
end