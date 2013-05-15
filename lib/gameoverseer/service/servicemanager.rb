class GameOverseer
  # ServiceManager
  class ServiceManager
    SERVICES = []

    def initialize
    end

    def process_command(hash)
      message = hash['message']
      command = message.split(/ /).first.sub('!','').to_sym
      SERVICES.each do |service|
        service.commands.each do |cmd|
          if cmd == command
            if service.respond_to?(cmd)
              service.send(cmd, hash)
              puts "ServiceManager: command: '#{cmd}', service: '#{service.class}'".foreground(:cyan) if $debug
            end
          else
          end
        end
      end
    end

    def process_event(called_event, data)
      SERVICES.each do |service|
        service.events.each do |event|
          if called_event == event
            if service.respond_to?(event)
              service.send(called_event, data)
            end
          end
        end
      end
    end
  end
end