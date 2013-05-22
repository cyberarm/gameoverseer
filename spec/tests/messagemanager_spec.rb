require_relative "../test_helper"

describe GameOverseer::MessageManager do
  before :each do
    @servicemanager = GameOverseer::ServiceManager.new
    @messagemanager = GameOverseer::MessageManager.new(@servicemanager)
  end

  describe "#add_message" do
    it "should respond to add_message" do
      @messagemanager.respond_to?(:add_message).should == true
    end
    
    it "should return true" do
      @messagemanager.add_message({'message' => "Hello World"}).should == true
    end
    
    it "should return false" do
      @messagemanager.add_message(:i_am_not_a_string!).should_not == true
    end
  end

  describe "#add_server_message" do
    it "should respond to add_server_message" do
      @messagemanager.respond_to?(:add_server_message).should == true
    end

    it "should return true" do
      @messagemanager.add_server_message("Server[Console]: Shutting down...").should == true
    end

    it "should return false" do
      @messagemanager.add_server_message(007).should_not == true
    end
  end

  describe "#is_command?" do
    it "should respond to is_command?" do
      @messagemanager.respond_to?(:is_command?).should == true
    end

    it "should respond with true" do
      @messagemanager.is_command?("!server status").should == true
    end

    it "should respond with false" do
      @messagemanager.is_command?("I'm not a command").should_not == true
    end
  end

  describe "#contains_bad_language?" do
    it "should respond to contains_bad_language?" do
      @messagemanager.respond_to?(:contains_bad_language?).should == true
    end

    it "should respond with true" do
      @messagemanager.contains_bad_language?("lol").should == true
    end

    it "should respond with false" do
      @messagemanager.contains_bad_language?("Good game").should_not == true
    end
  end
end