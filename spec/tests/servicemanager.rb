require_relative "../test_helper"

describe GameOverseer::ServiceManager do
  before do
    @servicemanager = GameOverseer::ServiceManager.new
  end

  describe "#process_command" do
    it "should respond to process_command" do
      @servicemanager.respond_to?(:process_command)
    end

    it "should not fail when sending valid commands" do
      pending
      @servicemanager.process_command({'message' => "!server"}).should be_instance_of(String)
      @servicemanager.process_command({'message' => "!server exit"}).should == true
    end

    it "should fail when calling non-existant command" do
      @servicemanager.process_command({'message' => "!players"}).should_not == true
    end
  end

  describe "#process_event" do
    it "should respond to process_event" do
      @servicemanager.respond_to?(:process_event)
    end

    it "should found and send event to service" do
      pending
      @servicemanager.process_event(:on_join, "Player").should == true
    end
  end
end