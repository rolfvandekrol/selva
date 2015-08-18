
# Make sure the paths of the gems in the Gemfile are set up correctly. We are
# not using Bundler.require here, because of the performance penalty that comes
# with it. Every file in the project manually requires its dependencies.
require 'bundler'
Bundler.setup(:default)

# Add the lib directory of the project to the include path, so we can easily
# require files from our project.
$: << File.dirname(__FILE__)

# Make sure the base of the project is included. This does not require all
# parts of Selva, but it makes the API of Selva available.
require 'selva'
