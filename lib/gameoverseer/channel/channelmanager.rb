class GameOverseer

  # The ChannelManager routes messages sent to the server to services.
  class ChannelManager
    CHANNELS = []

    # Subscribe "channel" to ServiceClass
    def self.subscribe(channel, klass)
      CHANNELS << {channel: channel.to_s, klass: klass}
    end

    # Push data to subscribers of "requested_channel"
    def push(requested_channel, data)
      CHANNELS.each do |channel|
        if requested_channel == channel[:channel]
          GameOverseer::ServiceManager::SERVICES.each do |service|
            if service.class.name == channel[:klass].class.name
              service.send(:update, data)
            end
          end
        end
      end
    end
  end
end