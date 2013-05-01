class GameOverseer
  module CommandHandler
    def self.help
      puts "GameOverseer Version #{GameOverseer::VERSION}"
      puts "n/ew - Creates a new project template."
      puts "g/enerate service name - Creates a new service template."
      puts "s/erver [-d/--debug] - Start the server, optionally in debug mode."
    end
  end
end