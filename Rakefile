task :default do
  exec "./bin/tic_tac_toe"
end

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = 'tic_tac_toe'
    gem.summary = "Play Tic-Tac-Toe using Curses"
    gem.email = "michael@grosser.it"
    gem.homepage = "http://github.com/grosser/#{gem.name}"
    gem.authors = ["Michael Grosser"]
  end

  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler, or one of its dependencies, is not available. Install it with: gem install jeweler"
end
