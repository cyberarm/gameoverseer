class GameOverseer
  class Service
    def self.inherited(subclass)
      $log.info "Service #{subclass} activated." if $log
      GameOverseer::ServiceManager::SERVICES.push(subclass.new)
    end

    def version
      "unknown"
    end
  end
end