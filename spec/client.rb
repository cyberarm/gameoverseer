GC::Profiler.enable

require "bundler/setup"
Bundler.require(:default)

trap("INT") { puts "Shutting down."; exit}

class GameOverseerClient < EventMachine::Connection
  attr_reader :host, :port, :id, :key

  def initialize(host = "localhost", port = 67281)
    @host = host
    @port = port
    @id = 0
    @key= 0
    @handshake =false
    @sent_msg  = 0
  end

  def post_init
    send_datagram(Oj.dump({'channel' => 'identity', 'mode' => 'connect', 'username' => "player", 'password' => "secret123"}), @host, @port)

    EventMachine::PeriodicTimer.new(0.5) do
      @sent_msg+=1

      if @handshake
        send_datagram(Oj.dump({'channel' => 'chat', 'message' => "Hello World", 'id' => @id, 'key' => @key}), @host, @port)
        send_datagram(Oj.dump({'channel' => 'chat', 'message' => "!ban cyberarm", 'id' => @id, 'key' => @key}), @host, @port)
      end

      if @sent_msg > 10
        send_datagram(Oj.dump({'channel' => 'identity', 'mode' => 'disconnect', 'id' => @id, 'key' => @key}), @host, @port)
        EventMachine::Timer.new(1) do
          exit
        end
      end
    end
  end

  def handshake(data)
    if data.kind_of? Hash
      if data['channel'] == 'identity'
        @id = data['id']
        puts @id
        @key= data['key']
      end
    end
  end

  def receive_data data
    data = Oj.load(data)
    unless @handshake
      handshake(data)
      @handshake = true
    end
    puts data
  end
end

EventMachine.run do
  EventMachine.open_datagram_socket("localhost", 0, GameOverseerClient)
end