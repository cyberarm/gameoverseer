require_relative "../test_helper"

describe GameOverseer::ClientAuthentication do
  before :each do
    @auth = GameOverseer::ClientAuthentication.new({'username' => 'Player', 'password' => 'secret123'})
  end

  describe "#authenticate" do
    it "should return true" do
      @auth.authenticate.should == true
    end
  end
end