require_relative "../test_helper"

describe GameOverseer::ServiceManager do
  before :each do
    @servicemanager = GameOverseer::ServiceManager.new
  end

  describe "#process_command" do
    it "should respond to process_command" do
      @servicemanager.respond_to?(:process_command)
    end

    it "should not fail when sending valid commands" do
      @servicemanager.process_command({'message' => "!server"}).should == true
      @servicemanager.process_command({'message' => "!server exit"}).should == true
    end

    it "should fail calling non-existant command" do
      @servicemanager.process_command({'message' => "!players"}).should_not == true
    end
  end
end