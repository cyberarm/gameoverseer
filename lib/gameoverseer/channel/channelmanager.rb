class GameOverseer
  class ChannelManager
    CHANNELS = []
    def initialize
    end

    def self.subscribe(channel, klasss)
      p caller
      puts "Got caller?"
      CHANNELS << {channel: channel, klass: klass}
    end

    def push(requested_channel, data)
      puts "H!"
      CHANNELS.each do |channel|
        if requested_channel == channel
          channel[:klass].send(:update, data)
        end
      end
    end
  end
end