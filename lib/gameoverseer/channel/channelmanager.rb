class GameOverseer

  # The ChannelManager routes messages sent to the server to services.
  class ChannelManager
    CHANNELS = []

    def self.subscribe(channel, klasss)
      CHANNELS << {channel: channel.to_s, klass: klass}
    end

    def push(requested_channel, data)
      CHANNELS.each do |channel|
        if requested_channel == channel
          GameOverseer::ServiceManager::SERVICES.each do |service|
            if service.name == channel[:klass].name
              service.send(:update, data)
            end
          end
        end
      end
    end
  end
end