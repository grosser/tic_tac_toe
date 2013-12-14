$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)

name = "tic_tac_toe"
require "#{name}/version"

Gem::Specification.new name, TicTacToe::VERSION do |s|
  s.summary = "Play Tic-Tac-Toe using Curses"
  s.email = "michael@grosser.it"
  s.homepage = "http://github.com/grosser/#{name}"
  s.authors = ["Michael Grosser"]
  s.executables = [name]
  s.files = `git ls-files`.split("\n")
  s.license = "MIT"
  s.add_runtime_dependency "dispel"
end

