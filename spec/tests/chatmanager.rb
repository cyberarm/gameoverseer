require_relative "../test_helper"

describe GameOverseer::ChatManager do
  before do
    @servicemanager = GameOverseer::ServiceManager.new
    @chatmanager = GameOverseer::ChatManager.new(@servicemanager)
  end

  describe "#add_message" do
    it "should respond to add_message" do
      @chatmanager.respond_to?(:add_message).should == true
    end
    
    it "should return true" do
      @chatmanager.add_message({'message' => "Hello World"}).should == true
    end
    
    it "should return false" do
      @chatmanager.add_message(:i_am_not_a_string!).should_not == true
    end
  end

  describe "#add_server_message" do
    it "should respond to add_server_message" do
      @chatmanager.respond_to?(:add_server_message).should == true
    end

    it "should return true" do
      @chatmanager.add_server_message("Server[Console]: Shutting down...").should == true
    end

    it "should return false" do
      @chatmanager.add_server_message(007).should_not == true
    end
  end

  describe "#is_command?" do
    it "should respond to is_command?" do
      @chatmanager.respond_to?(:is_command?).should == true
    end

    it "should respond with true" do
      @chatmanager.is_command?("!server status").should == true
    end

    it "should respond with false" do
      @chatmanager.is_command?("I'm not a command").should_not == true
    end
  end

  describe "#contains_bad_language?" do
    it "should respond to contains_bad_language?" do
      @chatmanager.respond_to?(:contains_bad_language?).should == true
    end

    it "should respond with true" do
      @chatmanager.contains_bad_language?("lol").should == true
    end

    it "should respond with false" do
      @chatmanager.contains_bad_language?("Good game").should_not == true
    end
  end
end