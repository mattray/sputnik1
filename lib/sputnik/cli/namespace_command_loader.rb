module Sputnik
  class CLI
    class NamespaceCommandLoader
      def initialize(root = Sputnik::Plugin)
        @root = root
      end

      def [](key)
        key.split(/:+/).reduce(@root) do |cls, name|
          if cls.const_defined? name.capitalize
            cls.const_get name.capitalize
          else
            return nil
          end
        end
      end
    end
  end
end