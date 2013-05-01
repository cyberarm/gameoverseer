require_relative "events"

class GameOverseer
  class EventManager
    def initialize(service_manager)
      @servermanager = service_manager
      @events = GameOverseer::Events.new
    end

    def process_event(called_event, data)
      found_event = false

      @events.each do |event|
        if event == called_event
          @service_manager.process_event(called_event, data)
          found_event = true
        end
      end
      return found_event
    end
  end
end