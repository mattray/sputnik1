require 'mixlib/cli'

module Sputnik
  class Plugin
    include Mixlib::CLI

    def self.call
      plugin = new
      plugin.call
    end

    def call
      puts "Sputnik::Plugin.call (YOU SHOULD DEFINE THIS!)"
    end

  end
end
