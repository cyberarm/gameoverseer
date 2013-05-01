require "erb"

class GameOverseer
  class Generator
    def initialize(type, name)
      case type
      when :project
        generate_project(name)
      when :service
        generate_service(name)
      end
    end

    def generate_project(name)
    end

    def generate_service(class_name)
      config = {}
      config[:service_class] = class_name
      file = ERB.new(open("templates/service.tt"))
      p file
    end
  end
end