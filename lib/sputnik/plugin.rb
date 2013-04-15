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

    option :log_level,
    :short => "-l LEVEL",
    :long => "--loglevel LEVEL",
    :description => "Set the log level (debug, info, warn, error, fatal)",
    :proc => lambda { |l| l.to_sym }

    option :log_location,
    :short => "-L LOGLOCATION",
    :long => "--logfile LOGLOCATION",
    :description => "Set the log file location, defaults to STDOUT",
    :proc => nil

    option :version,
    :short => '-v',
    :long => '--version',
    :description => 'Show Sputnik plugin version',
    :boolean => true,
    :proc => nil, #gets defined in the self.call
    :exit => 0

    # setup the base plugin, with logging and config
    def self.call
      parent = Sputnik::Plugin.new
      plugin = self.new
      name = plugin.class.name.split("::").last
      parent.options[:version][:proc] = Proc.new { puts "Sputnik #{name}: #{plugin.version}" }
      plugin.options.merge!(parent.options) #merge base options
      plugin.parse_options
      Config.merge!(plugin.config)
      self.configure_logging
      plugin.call
    end

    def version
      return "unknown"
    end

    def call
      puts "Sputnik::Plugin.call (YOU SHOULD DEFINE THIS!)"
    end

    def self.configure_logging
      Sputnik::Log.init(Sputnik::Config[:log_location])
      Sputnik::Log.level = Sputnik::Config[:log_level]
      Sputnik::Log.level = :debug if Sputnik::Config[:debug]
      Sputnik::Config[:debug] = true if Sputnik::Config[:log_level] == :debug
    end

  end
end
