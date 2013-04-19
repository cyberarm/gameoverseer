class GameOverseer
  class ClientManager
    CLIENTS = []

    def initialize(max_clients = GameOverseer::CONFIG[:max_players])
      @max_clients = max_clients
      @current_id = 0
    end

    def add(ip, port, key, data={})
      if CLIENTS.count > GameOverseer::CONFIG[:max_players]
        false
      else
        CLIENTS << GameOverseer::Client.new(ip, port, @current_id, key, data)
        @current_id+=1
        true
      end
    end

    def get(id, key)
      CLIENTS.each do |client|
        if client.id == id
          if client.key == key
            client
            $log.info "Found client: #{id}"
          end
        end
      end
    end
  end
end