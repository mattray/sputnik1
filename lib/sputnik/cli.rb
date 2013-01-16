require 'mixlib/cli'

require 'sputnik'
require 'sputnik/cli/namespace_command_loader'
require 'sputnik/cli/console'
require 'sputnik/cli/setup'

module Sputnik
  class CLI
    include Mixlib::CLI

    NO_PLUGIN_GIVEN = "You need to pass a plugin (e.g., sputnik PLUGIN)\n"

    banner('Usage: sputnik [plugin] [options]')

    option :debug,
    :long => '--debug',
    :description => 'Verbose debugging messages',
    :boolean => true

    option :help,
    :short => '-h',
    :long => '--help',
    :description => 'Show this message',
    :on => :tail,
    :boolean => true,
    :show_options => true,
    :exit => 0

    option :version,
    :short => '-v',
    :long => '--version',
    :description => 'Show sputnik version',
    :boolean => true,
    :proc => lambda { |v| puts "Sputnik: #{::Sputnik::VERSION}" },
    :exit => 0

    def initialize
      super
      @loader = NamespaceCommandLoader.new
      @setup = Setup.new
    end

    def run
      parse_and_validate_options
      plugin = parse_plugin
      @setup.call
      if cmd = @loader[plugin]
        cmd.call
        return 0
      else
        puts "Unknown '#{plugin}' plugin!"
        require 'pry'
        binding.pry
        return 1
      end
    end

    #cargo culted from knife
    def parse_and_validate_options
      # Checking ARGV validity *before* parse_options because
      # parse_options mangles ARGV in some situations
      if no_command_given?
        ARGV << '--help'
        print_help_and_exit(1, NO_PLUGIN_GIVEN)
      elsif no_plugin_given?
        if (want_help? || want_version?)
          print_help_and_exit
        else
          ARGV << '--help'
          print_help_and_exit(2, NO_PLUGIN_GIVEN)
        end
      end
    end

    def no_command_given?
      ARGV.empty?
    end

    def no_plugin_given?
      ARGV[0] =~ /^-/
    end

    def want_help?
      ARGV[0] =~ /^(--help|-h)$/
    end

    def want_version?
      ARGV[0] =~ /^(--version|-v)$/
    end

    def print_help_and_exit(exitcode=1, fatal_message=nil)
      puts (fatal_message) if fatal_message
      begin
        self.parse_options
      rescue OptionParser::InvalidOption => e
        puts "#{e}\n"
      end
      exit exitcode
    end

    #called after parse_and_validate_options, so assume ARGV is good
    def parse_plugin
      return ARGV[0]
    end

  end
end
