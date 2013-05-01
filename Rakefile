require "bundler/gem_tasks"

task default: [:test]

desc "Run tests"
task :test do
  exec("rspec spec/tests/*.rb -c")
end

namespace :doc do
  desc "Generate documentation"
  task :generate do
    exec("yard")
  end

  desc "Run documentation server"
  task :server do
    exec("yard server")
  end
end