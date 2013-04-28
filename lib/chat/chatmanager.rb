class GameOverseer
  class ChatManager
    MESSAGES = [] # Chat message for players
    SERVER_MESSAGES = [] # Chat messages from server

    def initialize(service_manager,banned_words = GameOverseer::CONFIG[:banned_words])
      @banned_words = banned_words
      @unprocessed_messages = []
      @service_manager = service_manager
    end

    # process message for commands or bad language.
    def add_message(hash)
      if hash['message']
        message = hash['message']
        if message.kind_of? String
          if is_command?(message)
            @service_manager.process_command(hash)

          elsif contains_bad_language?(message)
            message = filter_message(message)
            MESSAGES << message
            puts "ChatManager: message: #{message}".foreground(:yellow) if $debug
          else
            MESSAGES << message
            puts "ChatManager: message: #{message}".foreground(:yellow) if $debug
          end
          true
        end
      else
        false
        # raise ChatManager::MessageError
      end
    end

    def add_server_message(message)
      if message.kind_of? String
        SERVER_MESSAGES << message
        true
      else
        false
      end
    end

    # Checks first character for '!', indictating command.
    def is_command?(message)
      if message[0,1] == "!"
        true
      end
    end

    def contains_bad_language?(message)
      bad_words = false
      @banned_words.each do |word|
        if message.include?(word)
          bad_words = true
        end
      end
      return bad_words
    end
  end
end