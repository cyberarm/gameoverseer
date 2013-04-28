class GameOverseer
  class ClientManager
    CLIENTS = []

    def initialize(max_clients = GameOverseer::CONFIG[:max_players])
      @max_clients = max_clients
      @current_id  = 0
    end

    def add(ip, port, key, data={})
      if CLIENTS.count > GameOverseer::CONFIG[:max_players]
        false
      else
        if data['username']
          CLIENTS << GameOverseer::Client.new(ip, port, @current_id, key, {'username' => data['username']})
          temp_id = @current_id
          @current_id+=1
          puts "ClientManager: client connected".foreground(:magenta) if $debug
          return temp_id
        end
      end
    end

    def remove(data)
      CLIENTS.each do |client|
        if client.key == data['key']
          if client.id == data['id']
            CLIENTS.delete(client)
            puts "ClientManager: client disconnected".foreground(:magenta) if $debug
            true
          end
        else
          false
        end
      end
    end

    def get(id, key)
      CLIENTS.each do |client|
        if client.id == id
          if client.key == key
            $log.info "Found client: #{id}"
            return client if client.key
          end
        end
      end
    end

    def known_client?(data)
      client = get(data['id'], data['key'])
      if client.kind_of? Array
        client = nil
      end
      if client
        true
      else
        false
      end
    end
  end
end