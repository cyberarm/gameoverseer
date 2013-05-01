class GameOverseer
  class Server < EventMachine::Connection
    def initialize
      super
      @service_manager = GameOverseer::ServiceManager.new
      @client_manager  = GameOverseer::ClientManager.new
      @event_manager   = GameOverseer::EventManager.new(@service_manager)
      @chat_manager    = GameOverseer::ChatManager.new(@service_manager)
      insert_spacer
        text_introduction
        text_status
      insert_spacer
      puts "Found services:"
      GameOverseer::ServiceManager::SERVICES.each do |service|
        puts "#{service.class}v#{service.version}".foreground(:green)
      end
      insert_spacer

      unless $debug
        Thread.new do
          loop do
            start_input_monitor
          end
        end
      end
    end

    def insert_spacer(spacer = "-", width = 50)
      width.times do
        print "#{spacer}".foreground(:yellow)
      end
      puts
    end

    def text_introduction
      puts "GameOverseer-#{GameOverseer::VERSION} (#{GameOverseer::VERSION_NAME})".foreground(:blue).background(:white)
      puts "Server running on: #{GameOverseer::CONFIG[:ip_address]}:#{GameOverseer::CONFIG[:port]}"
    end

    def text_status
      puts "Status:" + "#{status}".foreground(:green)
    end

    def status
      # Todo: Make this return actual status, e.g. Overloaded, Failing, OK
      "OK"
    end

    def start_input_monitor
      puts
      print "> "
      input = gets.chomp
      if input[0,1] == '!'
        @chat_manager.add_message('message' => input, 'console' => true)
      else
        @chat_manager.add_server_message("Server[Console]: #{input}")
      end
    end

    def receive_data data
      begin
          data = Oj.strict_load(data)
        rescue => e
          $log.error "Invalid data received: #{e.to_s}"
          data = nil
        end
    
      if data.kind_of? Hash
        if data['channel'] == 'identity'
          if data['mode']  == 'connect'
            if GameOverseer::ClientAuthentication.new(data)
              port, ip = Socket.unpack_sockaddr_in(get_peername)
              handshake = GameOverseer::ClientHandshake.new
              id = @client_manager.add(ip, port, handshake.key, data)
              send_data(Oj.dump({'channel' => 'identity', 'id' => id, 'key' => handshake.key}))
            end
            
          elsif data['mode'] == 'disconnect'
            @client_manager.remove(data)
          end
    
        # Define channels here
      elsif data['channel'] == 'server'
          # @chat_manager.add_server_message(data)
    
        elsif data['channel'] == 'chat'
          @chat_manager.add_message(data) if @client_manager.known_client?(data)
    
        elsif data['channel'] == 'world'
          # TODO: Pass off to world manager service
        end
      end
      $log.info "Received #{data} from #{data['id']}"
      # $log.debug "#{GC::Profiler.report}"
    end

    def unbind
      puts "Shutting Down..."
    end
  end
end