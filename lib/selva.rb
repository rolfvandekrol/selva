
# Provide the main module for Selva, and make sure all the components of
# Selva are available for autoloading. We do not require all the components 
# here, because the dependencies of some CLI operations are totally different
# from the dependencies of the actual server.

module Selva
  autoload :CLI, 'selva/cli'
  autoload :Server, 'selva/server'
  autoload :Router, 'selva/router'
  autoload :SocketMiddleware, 'selva/socket_middleware'
end