class GameOverseer
  class Client
    attr_reader :ip, :port, :id, :key
    attr_accessor :data

    def initialize(ip, port, id, key, data={})
      @ip   = ip
      @port = port
      @id   = id
      @key  = key
      @data = data
    end
  end
end