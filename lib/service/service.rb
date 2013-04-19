class GameOverseer
  class Service
    def self.inherited(subclass)
      $log.info "Service #{subclass} activated."
      GameOverseer::ServiceManager::SERVICES.push(subclass.new)
    end
  end
end