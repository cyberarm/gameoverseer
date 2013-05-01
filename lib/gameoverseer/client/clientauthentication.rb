class GameOverseer
  class ClientAuthentication
    def initialize(hash)
      @username = hash['username']
      @password = hash['password']
      authenticate
    end

    def authenticate
      true
    end
  end
end