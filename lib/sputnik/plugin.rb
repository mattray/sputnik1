require 'mixlib/cli'

module Sputnik
  class Plugin
    include Mixlib::CLI

    #this should be overridden
    banner('Usage: sputnik [plugin] [options]')

    option :debug,
    :long => '--debug',
    :description => 'Enable debugging if available',
    :boolean => true

    option :version,
    :short => '-v',
    :long => '--version',
    :description => 'Show Sputnik plugin version',
    :boolean => true,
    :proc => nil, #gets defined in the self.call
    :exit => 0

    def self.call
      parent = Sputnik::Plugin.new
      plugin = self.new
      name = plugin.class.name.split("::").last
      parent.options[:version][:proc] = Proc.new { puts "Sputnik #{name}: #{plugin.version}" }
      plugin.options.merge!(parent.options) #merge base options
      plugin.parse_options
      plugin.call
    end

    def version
      return "unknown"
    end

    def call
      puts "Sputnik::Plugin.call (YOU SHOULD DEFINE THIS!)"
    end

  end
end
