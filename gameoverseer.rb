GC::Profiler.enable

require "bundler/setup"
Bundler.require(:default)
require "securerandom"

require_relative "config/config"
$log = Log4r::Logger.new("GameOverseer")
$log.outputters = Log4r::FileOutputter.new("GameOverseerLog", filename: "#{Dir.pwd}/#{GameOverseer::CONFIG[:logger_directory]}/log.txt")

require_relative "lib/version"
require_relative "lib/service/service"
require_relative "lib/service/servicemanager"
require_relative "lib/chat/chat"
require_relative "lib/chat/chatmanager"
require_relative "lib/client/client"
require_relative "lib/client/clientmanager"
require_relative "lib/client/clienthandshake"
require_relative "lib/server/server"

require_relative "services/sentinel"

ip   = GameOverseer::CONFIG[:ip_address]
port = GameOverseer::CONFIG[:port]

EventMachine.run do
  EventMachine.open_datagram_socket ip, port, GameOverseer::Server
end