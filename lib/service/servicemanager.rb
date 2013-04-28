class GameOverseer
  class ServiceManager
    SERVICES = []

    def initialize
    end

    def process_command(hash)
      message = hash['message']
      command = message.split(/ /).first.sub('!','').to_sym
      found_cmd = false
      SERVICES.each do |service|
        service.commands.each do |cmd|
          if cmd == command
            if service.respond_to?(cmd.to_sym)
              service.send(cmd.to_sym, hash)
              puts "ServiceManager: command: '#{cmd}', service: '#{service.class}'".foreground(:cyan) if $debug
              found_cmd = true
            end
          else
          end
        end
      end
      return found_cmd
    end
  end
end