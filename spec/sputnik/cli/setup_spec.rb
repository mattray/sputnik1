require 'spec_helper'
require 'sputnik/cli/setup'

describe Sputnik::CLI::Setup do
  before do
    require 'rubygems'
    Gem.stub(:find_files).with('sputnik/plugin/**/*.rb') {[
      '/blah/bliff/sputnik/plugin/one.rb',
      '/zip/zap/sputnik/plugin/one/two.rb',
      '/splish/splash/sputnik/plugin/one/two/three.rb'
    ]}
    Kernel.stub :require
    subject.call
  end
  it "requires the plugin files" do
    Kernel.should have_received(:require).with('sputnik/plugin/one')
    Kernel.should have_received(:require).with('sputnik/plugin/one/two')
    Kernel.should have_received(:require).with('sputnik/plugin/one/two/three')
  end
end
