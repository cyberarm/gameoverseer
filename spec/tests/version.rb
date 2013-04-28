require_relative "../test_helper"

describe GameOverseer do
  describe GameOverseer::VERSION do
    it "should have a VERSION" do
      GameOverseer::VERSION.should == "0.0.1"
    end
  end

  describe GameOverseer::VERSION_NAME do
    it "should have a VERSION_NAME" do
      GameOverseer::VERSION_NAME.should == "Ice Crystal"
    end
  end
end