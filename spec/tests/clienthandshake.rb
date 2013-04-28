require_relative "../test_helper"

describe GameOverseer::ClientHandshake do
  before :each do
    @clienthandshake = GameOverseer::ClientHandshake.new
  end

  describe "#initialize" do
    it "should return key" do
      @clienthandshake.key.should be_kind_of(String)
    end
  end
end