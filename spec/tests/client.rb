require_relative "../test_helper"

describe GameOverseer::Client do
  before do
    @key    = GameOverseer::ClientHandshake.new
    @client = GameOverseer::Client.new("127.0.0.1", 67891, 1, @key.key, {'username' => 'Player'})
  end

  describe "#initialize" do
    it "should return ip" do
      @client.ip.should be_kind_of(String)
    end

    it "should return port" do
      @client.port.should be_kind_of(Integer)
    end

    it "should return key" do
      @client.key.should be_kind_of(String)
    end

    it "should return data" do
      @client.data.should be_kind_of(Hash)
    end
  end
end