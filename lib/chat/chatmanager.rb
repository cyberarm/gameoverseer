class GameOverseer
  class ChatManager
    MESSAGES = [] # Chat message for players
    SERVER_MESSAGES = [] # Chat messages from server
    def initialize(banned_words = ["lol", "ftw"], service_manager)
      @unprocessed_messages = []
      @service_manager = service_manager
    end

    # process message for commands and filter language after command filter.
    def add_message(hash)
      if hash[:message]
        message = hash[:message]
        if message.kind_of? String
          if is_command?(message)
            @service_manager.process_command(hash)

          elsif contains_bad_language?(message)
            message = filter_message(message)
            MESSAGES << message
          end
        end
      else
        # raise ChatManager::MessageError
      end
    end

    def add_server_message(message)
      SERVER_MESSAGES << message if message.kind_of? String
    end

    def is_command?(message)
      if message[0,1] == "!"
        true
      end
    end
  end
end