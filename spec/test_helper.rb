require "bundler"
Bundler.require(:default)
Bundler.require(:test)

SimpleCov.start do
  add_filter "spec"
  add_filter "services"
end
$testing = true

# Dir["#{Dir.pwd}/lib/**/*.rb"].each do |file|
#   require_relative file unless file.include?("generator") or file.include?('gui')
# end
#
# require_relative "../lib/gameoverseer/config/config"
require "gameoverseer"
# require_relative "../lib/gameoverseer/services/sentinel"