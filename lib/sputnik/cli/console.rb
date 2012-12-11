module Sputnik
  class CLI
    class Console
      def error(e)
        $stderr.puts e.message
        # $stderr.puts e.backtrace.join("\n")
      end
    end
  end
end