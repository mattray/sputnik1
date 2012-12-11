require 'mixlib/cli'

module Sputnik
  DEBUG = false
  class Plugin
    include Mixlib::CLI

    def self.call(*args)
      plugin = new
      plugin.parse_options args
      plugin.call
    end

    def call(*args)

    end

    # option :debug,
    #   :boolean => true,
    #   :default => false,
    #   :long => "--debug",
    #   :description => "Show lots of Sputnik debugging output.",
    #   :proc => Proc.new { |key| Sputnik::DEBUG = key }
    #
    # option :help,
    #   :short => "-h",
    #   :long => "--help",
    #   :description => "Show this message",
    #   :on => :tail,
    #   :boolean => true,
    #   :show_options => true,
    #   :exit => 0
    #
    # option :version,
    #   :short => "-v",
    #   :long => "--version",
    #   :description => "Show Test Kitchen version",
    #   :boolean => true,
    #   :proc => lambda {|v| puts "sputnik: #{::Sputnik::VERSION}"},
    #   :exit => 0
  end
end