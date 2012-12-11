require 'spec_helper'
require 'sputnik/cli'

describe 'the sputnik CLI' do
  before do
    @foo = mock('the foo command')
    @loader = {
      'foo:bar:baz' => @foo
    }
    @console = mock('console')
    @setup = mock('process setup')
    @setup.stub(:call)
    @cli = Sputnik::CLI.new(@loader, @console, @setup)
  end
  describe 'sending it a known command with options' do
    before do
      @foo.stub! :call
      @cli.start 'foo:bar:baz', '-h', '--no-worries'
    end

    it 'runs the setup' do
      @setup.should have_received :call
    end

    it "runs that command with those options" do
      @foo.should have_received(:call).with('-h', '--no-worries')
    end
  end

  describe "sending it an unkown command" do
    before do
      @console.stub! :error
      @status = @cli.start 'unknown:command:dude'
    end
    it "logs an error to the console" do
      @console.should have_received :error
    end

    it 'should be a failing exit status' do
      @status.should >= 0
    end
  end

  describe "a command that raises an exception" do
    before do
      @console.stub! :error
      @boomer = Class.new(Exception)
      @boomer.send(:define_method, :to_exit_status) {256}
      @loader['boom'] = proc do
        fail @boomer, 'boom!'
      end
      @status = @cli.start 'boom'
    end

    it "logs an error to the console" do
      @console.should have_received(:error)
    end

    it "should be a failing exit status" do
      @status.should eql 256
    end
  end
end