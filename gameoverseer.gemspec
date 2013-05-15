# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "gameoverseer/version"

Gem::Specification.new do |s|
  s.name = "gameoverseer"
  s.version = GameOverseer::VERSION
  s.authors = ["Cyberarm"]
  s.email = ["matthewlikesrobots@gmail.com"]
  s.homepage = "https://github.com/cyberarm/jared"
  s.summary = "Generic game server."
  s.description = "GameOverseer is design to simplify the making of multiplayer games by providing a means as to which to simply and easily write a game server."

  s.rubyforge_project = "gameoverseer"

  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib", "bin"]

  s.add_runtime_dependency "eventmachine"
  s.add_runtime_dependency "log4r"
  s.add_runtime_dependency "oj"
  s.add_runtime_dependency "os"
  s.add_runtime_dependency "rainbow"

  s.add_development_dependency "rspec"
  s.add_development_dependency "simplecov"
end