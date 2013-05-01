class GameOverseer
  class ClientHandshake
    attr_reader :key

    def initialize
      @key = SecureRandom.hex.to_s
    end
  end
end