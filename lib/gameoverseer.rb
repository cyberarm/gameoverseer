require "securerandom"
require "eventmachine"
require "log4r"
require "oj"
require "os"
require "rainbow"

if ARGV[0] == '-d' or ARGV[0] == '--debug'
  puts "--- ".foreground(:yellow) + "Running in Debug Mode".foreground(:red) + " ---".foreground(:yellow)
  puts "Overview: Ruby: #{RUBY_VERSION}, RubyGems: #{Gem::VERSION}".foreground(:red)
  puts "Loaded gems:".foreground(:red)
  Gem.loaded_specs.values.map {|x| puts "#{x.name} #{x.version}".foreground(:red)}
  # require "profile"
  $debug = true
end

require_relative "gameoverseer/config/config"
$log = Log4r::Logger.new("GameOverseer")
$log.outputters = Log4r::FileOutputter.new("GameOverseerLog", filename: "#{Dir.pwd}/lib/gameoverseer/#{GameOverseer::CONFIG[:logger_directory]}/log.txt")

require_relative "gameoverseer/version"
require_relative "gameoverseer/service/service"
require_relative "gameoverseer/service/servicemanager"

require_relative "gameoverseer/event/eventmanager"

require_relative "gameoverseer/chat/chatmanager"

require_relative "gameoverseer/client/client"
require_relative "gameoverseer/client/clientmanager"
require_relative "gameoverseer/client/clienthandshake"
require_relative "gameoverseer/client/clientauthentication"
require_relative "gameoverseer/server/server"

require_relative "gameoverseer/services/sentinel"

ip   = GameOverseer::CONFIG[:ip_address]
port = GameOverseer::CONFIG[:port]

# EventMachine.run do
#   EventMachine.open_datagram_socket ip, port, GameOverseer::Server
# end