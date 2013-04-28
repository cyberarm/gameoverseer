require "bundler/setup"
Bundler.require(:default)
require "securerandom"

if ARGV[0] == '-d' or ARGV[0] == '--debug'
  puts "--- ".foreground(:yellow) + "Running in Debug Mode".foreground(:red) + " ---".foreground(:yellow)
  puts "Overview: Ruby: #{RUBY_VERSION}, RubyGems: #{Gem::VERSION}".foreground(:red)
  puts "Loaded gems:".foreground(:red)
  Gem.loaded_specs.values.map {|x| puts "#{x.name} #{x.version}".foreground(:red)}
  # require "profile"
  $debug = true
end

require_relative "config/config"
$log = Log4r::Logger.new("GameOverseer")
$log.outputters = Log4r::FileOutputter.new("GameOverseerLog", filename: "#{Dir.pwd}/#{GameOverseer::CONFIG[:logger_directory]}/log.txt")

require_relative "lib/version"
require_relative "lib/service/service"
require_relative "lib/service/servicemanager"

require_relative "lib/chat/chatmanager"

require_relative "lib/client/client"
require_relative "lib/client/clientmanager"
require_relative "lib/client/clienthandshake"
require_relative "lib/client/clientauthentication"
require_relative "lib/server/server"

require_relative "services/sentinel"

ip   = GameOverseer::CONFIG[:ip_address]
port = GameOverseer::CONFIG[:port]

EventMachine.run do
  EventMachine.open_datagram_socket ip, port, GameOverseer::Server
end