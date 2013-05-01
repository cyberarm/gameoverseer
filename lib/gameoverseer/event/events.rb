class GameOverseer
  class Events
    def initialize
      list_valid_events
    end

    def list_valid_events
      [
        :on_join,
        :on_quit,
        :on_move
      ]
    end
  end
end