require 'sputnik'
require 'sputnik/cli/namespace_command_loader'
require 'sputnik/cli/console'
require 'sputnik/cli/setup'

module Sputnik
  class CLI
    def initialize(loader = NamespaceCommandLoader.new, console = Console.new, setup = Setup.new)
      @loader = loader
      @console = console
      @setup = setup
    end

    def start(*args)
      @setup.call *args
      if cmd = @loader[args.first]
        cmd.call *args.slice(1..-1)
        return 0
      end
      fail UnknownCommandError, args.first
    rescue Exception => e
      @console.error(e)
      e.respond_to?(:to_exit_status) ? e.to_exit_status : 1
    end

    class << self
      def start(*args)
        new.start *args
      end
    end
  end

  class UnknownCommandError < StandardError
    def initialize(command)
      super "unknown command #{command}"
    end
  end
end