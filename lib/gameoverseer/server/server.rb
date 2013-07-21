class GameOverseer

  # The CPU of GameOverseer as it were.
  class Server
    include Celluloid::IO
    finalizer :finalize

    # Setup for the server
    def initialize
      super
      # Create instances of the various managers
      @service_manager = GameOverseer::ServiceManager.new
      @channel_manager = GameOverseer::ChannelManager.new
      @client_manager  = GameOverseer::ClientManager.new
      @event_manager   = GameOverseer::EventManager.new(@service_manager)
      @message_manager = GameOverseer::MessageManager.new(@service_manager)

      @server = UDPSocket.new
      @server.bind(GameOverseer::CONFIG[:ip_address], GameOverseer::CONFIG[:port])

      display_env
      async.run
    end

    def finalize
      @server.close if @server
    end

    def run
      loop { handle_connection }
    end

    # Receive data from clients
    def handle_connection
      socket = @server.recvfrom(4096)
      data = socket[0]
      begin
        data = Oj.strict_load(data)
      rescue ParseError
        $log.error "Invalid data received: #{data.to_s}"
        data = nil
      end

      # Verify that received data is a Hash, if it is not, ignore it
      if data.kind_of? Hash
        if data['channel'] == 'identity'
          if data['mode']  == 'connect'
            if GameOverseer::ClientAuthentication.new(data)
              port = socket[1][1]
              ip = socket[1][3]
              handshake = GameOverseer::ClientHandshake.new
              id = @client_manager.add(ip, port, handshake.key, data)
              @server.send(Oj.dump({'channel' => 'identity', 'id' => id, 'key' => handshake.key}), 0, ip, port)
            end
            
          elsif data['mode'] == 'disconnect'
            @client_manager.remove(data)
          end
        end
    
        if data['channel'] == 'chat'
          @message_manager.add_message(data) if @client_manager.known_client?(data)
        end

        @channel_manager.push(data['channel'], data) if @client_manager.known_client?(data)
        $log.info "Received #{data} from #{data['id']} for channel #{data['channel']}"
      end
    end

    def display_env
      insert_spacer
        text_introduction
        text_status
      insert_spacer
      puts "Found services:"
      GameOverseer::ServiceManager::SERVICES.each do |s|
        GameOverseer::ServiceManager::SERVICES.delete(s)
        GameOverseer::ServiceManager::SERVICES << s.new if s.class == Class
        GameOverseer::ServiceManager::SERVICES << s.class.new unless s.class == Class
      end
      GameOverseer::ServiceManager::SERVICES.each do |service|
        puts "#{service.class}v#{service.version}".foreground(:green)
      end
      insert_spacer

      unless $debug or $testing
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

    # puts startup information
    def text_introduction
      puts "GameOverseer-#{GameOverseer::VERSION} (#{GameOverseer::VERSION_NAME})".foreground(:blue).background(:white)
      puts "Server running on: #{GameOverseer::CONFIG[:ip_address]}:#{GameOverseer::CONFIG[:port]}"
    end

    # puts status
    def text_status
      puts "Status:" + "#{status}".foreground(:green)
    end

    # Status of server
    def status
      # Todo: Make this return actual status, e.g. Overloaded, Failing, OK
      "OK"
    end

    # Listen for text input
    def start_input_monitor
      puts
      print "> "
      input = gets.chomp
      if input[0,1] == '!'
        @message_manager.add_message('message' => input, 'console' => true)
      else
        @message_manager.add_server_message("Server[Console]: #{input}")
      end
    end

    def unbind
      puts "Shutting Down..."
    end
  end
end