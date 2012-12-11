require 'spec_helper'
require 'sputnik/cli'

describe 'NamespaceCommandLoader' do
  before do
    @root = Class.new
    @loader = Sputnik::CLI::NamespaceCommandLoader.new(@root)
  end

  it 'returns nil if a command cannot be found' do
    @loader['piffle'].should be_nil
  end

  describe "a deeply nested command" do
    before do
      @root.class_eval do
        class Foo
          class Bar
            class Baz
            end
          end
        end
      end
    end
    it 'is found by colon separated namespace' do
      @loader['foo:bar:baz'].should eql @root.const_get(:Foo)::Bar::Baz
    end
  end
end
