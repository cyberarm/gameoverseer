require "bundler"
Bundler.require(:default)
Bundler.require(:test)

SimpleCov.start do
  add_filter "spec"
  add_filter "services"
end
$testing = true

Dir["#{Dir.pwd}/lib/**/*.rb"].each do |file|
  require_relative file unless file.include?('gui')
end

require_relative "../config/config"
require_relative "../services/sentinel"