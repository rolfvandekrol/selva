
# The Selva CLI application is build using Thor. Make sure Thor is available
require 'thor'

module Selva
  # Construct the base of the CLI application. The registration of all commands
  # happens below.
  class CLI < Thor
    include Thor::Actions

    class_option :verbose, :type => :boolean, :aliases => [:v]
  end
end

# All commands are registered here and included from separate files. Otherwise
# this file grows very large, very fast. The command files use 
# Selva::CLI.class_eval to register the commands.
[
  :run_migrations,
  :server
].each do |key|
  require "selva/cli/#{key}"
end