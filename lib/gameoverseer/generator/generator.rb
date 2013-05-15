require "erb"
require "fileutils"

class GameOverseer
  class Generator
    def initialize(type, name)
      @path = Gem::Specification.find_by_name("gameoverseer").gem_dir
      $generator_config = {}
      case type
      when :project
        generate_project(name)
      when :service
        generate_service(name)
      end
    end

    def generate_project(name)
      unless File.exists?(name.downcase) and File.directory?(name.downcase)
        $generator_config[:project_name] = name
        puts "Creating directory: #{name.downcase}"
        Dir.mkdir(name.downcase)
        puts "Done.".foreground(:green)

        puts "Creating directory: lib"
        Dir.mkdir(Dir.pwd+"/#{name.downcase}/lib")
        puts "Done.".foreground(:green)

        puts "Creating directory: services"
        Dir.mkdir(Dir.pwd+"/#{name.downcase}/services")
        puts "Done.".foreground(:green)

        puts "Creating directory: logs"
        Dir.mkdir(Dir.pwd+"/#{name.downcase}/logs")
        puts "Done.".foreground(:green)

        puts "Creating file: -> #{name}.rb"
        FileUtils.cp("#{@path}/lib/gameoverseer/generator/templates/project/runner.rb", "#{Dir.pwd}/#{name.downcase}/#{name}.rb")
        puts "Done".foreground(:green)

        puts "Creating file: -> /lib/server.rb"
        FileUtils.cp("#{@path}/lib/gameoverseer/generator/templates/project/lib/server.rb", "#{Dir.pwd}/#{name.downcase}/lib/server.rb")
        puts "Done".foreground(:green)
        puts
        puts "Finished generating.".foreground(:green)
      else
        puts "GameOverseer Project Generator Failed: Directory '#{name.downcase}' already in use in this directory.".foreground(:red)
      end
    end

    def generate_service(class_name)
      if File.exists?("services") and File.directory?("services")
        $generator_config[:class_name] = class_name
        file = open("#{@path}/lib/gameoverseer/generator/templates/service.tt").read
        erb  = ERB.new(file)
        puts erb.result
      else
        puts "GameOverseer Service Generator Failed: Could not find 'services' directory in current directory.".foreground(:red)
      end
    end

    def get_binding
      binding
    end
  end
end