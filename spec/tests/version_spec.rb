require_relative "../test_helper"

describe GameOverseer do
  describe GameOverseer::VERSION do
    it "should have a VERSION" do
      GameOverseer::VERSION.should be_a(String)
    end
  end

  describe GameOverseer::VERSION_NAME do
    it "should have a VERSION_NAME" do
      GameOverseer::VERSION_NAME.should be_a(String)
    end
  end
end