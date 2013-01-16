require 'rubygems'

module Sputnik
  class CLI
    class Setup
      def call
        logical_paths(Gem.find_files('sputnik/plugin/**/*.rb')).each do |path|
          require path
        end
      end

      def logical_paths(absolute_paths)
        absolute_paths.map do |absolute|
          "sputnik/plugin#{absolute.split('sputnik/plugin').last}".gsub('.rb','')
        end
      end
    end
  end
end
