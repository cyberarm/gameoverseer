require "securerandom"
require "celluloid/io"
require "log4r"
require "oj"
require "os"
require "rainbow"
require "pry"
require "pry-rescue" if $testing

require_relative "gameoverseer/config/config"
$log = Log4r::Logger.new("GameOverseer")
$log.outputters = Log4r::FileOutputter.new("GameOverseerLog", filename: "#{Dir.pwd}/#{GameOverseer::CONFIG[:logger_directory]}/log.txt")

require_relative "gameoverseer/version"

require_relative "gameoverseer/service/service"
require_relative "gameoverseer/service/servicemanager"

require_relative "gameoverseer/event/eventmanager"

require_relative "gameoverseer/channel/channelmanager"

require_relative "gameoverseer/message/messagemanager"

require_relative "gameoverseer/client/client"
require_relative "gameoverseer/client/clientmanager"
require_relative "gameoverseer/client/clienthandshake"
require_relative "gameoverseer/client/clientauthentication"
require_relative "gameoverseer/server/server"

require_relative "gameoverseer/services/sentinel"