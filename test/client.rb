GC::Profiler.enable

require "bundler/setup"
Bundler.require(:default)

trap("INT") { puts "Shutting down."; exit}

class GameOverseerClient < EventMachine::Connection
  def initialize
    @host = "localhost"
    @port = 67281
    @id = 0
    @key= 0
    @handshake=false
    @sent_msg = 0
  end

  def handshake(data)
    if data.kind_of? Hash
      if data['ok']
        @id = data['id']
        @key= data['key']
      end
    end
  end

  def disconnect(id, key)
    send_datagram({:request_token => true, data: {username: "cyberarm"}}.to_json, @host, @port)
    puts "Garbage Collections: #{GC.count}"
    exit
  end

  def post_init
    send_datagram({:request_token => true}.to_json, @host, @port)

    EventMachine::PeriodicTimer.new(0.5) do
      @sent_msg+=1

      if @sent_msg > 10
        disconnect(@id, @key)
      end

      if @handshake
        send_datagram({channel: :chat, message: "Hello World", id: @id, key: @key}.to_json, @host, @port)
      end
    end
  end

  def receive_data data
    data = JSON.parse(data)
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