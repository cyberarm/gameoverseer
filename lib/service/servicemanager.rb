class GameOverseer
  class ServiceManager
    SERVICES = []

    def initialize
    end

    def process_command(command, author)
      list = command.split(/ /)
      SERVICES.each do |service|
        service.commands.each do |command|
          if command == list[0].sub("!",'')
            server.chat_command(command)
          end
        end
      end
    end
  end
end