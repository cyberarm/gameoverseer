require_relative "../test_helper"

describe GameOverseer::Service do
  before :each do
    @service = Sentinel.new
  end

  describe "#events" do
    it "should respond to events" do
      @service.respond_to?(:events).should == true
    end

    it "should have events as an array" do
      @service.events.kind_of?(Array).should == true
    end

    it "events should only have symbols in the array" do
      @service.events.each do |event|
        event.kind_of?(Symbol).should == true
        @service.respond_to?(event).should == true
      end
    end
  end

  describe "#commands" do
    it "should respond to commands" do
      @service.respond_to?(:commands).should == true
    end

    it "should have services as an array" do
      @service.commands.kind_of?(Array).should == true
    end

    it "commands should only have symbols in array" do
      @service.commands.each do |command|
        command.kind_of?(Symbol).should == true
        @service.respond_to?(command).should == true
      end
    end
  end
end