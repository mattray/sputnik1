module Sputnik
  class CLI
    class Setup
      def call(*args)
        require 'rubygems'
        #gem 'sputnik-cloudlauncher'
        logical_paths(Gem.find_files('sputnik/plugin/**/*.rb')).each do |path|
          Kernel.require path
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
