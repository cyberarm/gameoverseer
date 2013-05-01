require "gameoverseer"
require_relative "lib/server"

EventMachine.run do
  EventMachine.open_datagram_socket "localhost", GameOverseer::CONFIG[:port], Server
end