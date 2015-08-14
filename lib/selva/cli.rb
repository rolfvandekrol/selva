require 'thor'

module Selva
  class CLI < Thor
    include Thor::Actions

    class_option :verbose, :type => :boolean, :aliases => [:v]
  end
end

[
  :run_migrations,
  :server
].each do |key|
  require "selva/cli/#{key}"
end