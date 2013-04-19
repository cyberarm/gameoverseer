class GameOverseer
  class Server < EventMachine::Connection
    def initialize
      super
      @service_manager = GameOverseer::ServiceManager.new
      @client_manager  = GameOverseer::ClientManager.new
      @chat_manager    = GameOverseer::ChatManager.new(GameOverseer::CONFIG[:bad_words_array], @service_manager)
      insert_spacer
      puts "GameOverseer v#{GameOverseer::VERSION} is running."
      insert_spacer
      puts "Found services:"
      GameOverseer::ServiceManager::SERVICES.each do |service|
        puts "#{service.class} v#{service.version}"
      end
      insert_spacer
    end

    def insert_spacer(spacer = "-", width = 50)
      width.times do
        print "#{spacer}"
      end
      puts
    end

    def post_init
      $log.info "Server Running"
      
    end

    def receive_data data
      begin
        data = JSON.parse(data)
      rescue JSON::ParserError
        $log.error "Invalid json data received: #{data.to_s}"
      end

      # p "Received: #{data}"
      if data.kind_of? Hash
        if data['request_token']
          port, ip = Socket.unpack_sockaddr_in(get_peername)
          handshake = GameOverseer::ClientHandshake.new
          id = @client_manager.add(ip, port, handshake, data['data'])
          send_data({ok: true, id: id, key: handshake.key}.to_json)

        # Define channels here
        elsif data[:channel] == :chat
          @chat_manager.add_message(data)

        elsif data[:channel] == :world
          # TODO: Pass off to world manager service
        end
      end
      $log.info "Received #{data} from #{ip}:#{port}"
      # $log.debug "#{GC::Profiler.report}"
    end

    def unbind
      puts "Bye Client!"
    end
  end
end